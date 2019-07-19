import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:long_life_burning/widgets/date_utils.dart';
import 'package:long_life_burning/widgets/gesture_detector.dart';
import 'package:long_life_burning/widgets/platform_widgets.dart';
import 'package:long_life_burning/modules/calendar/customization/customization.dart';
import 'package:long_life_burning/modules/calendar/logic/calendar_logic.dart';
import 'package:long_life_burning/modules/calendar/widgets/widgets.dart';

export 'package:long_life_burning/modules/calendar/customization/customization.dart';

typedef String TextBuilder(DateTime date, dynamic locale);
typedef void OnDaySelected(DateTime day, List events);
typedef void OnVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format);
typedef void OnHeader();
enum CalendarFormat {
  month,
  week,
}
enum StartingDayOfWeek {
  monday,
  sunday,
}
enum AvailableGestures {
  none,
  verticalSwipe,
  horizontalSwipe,
  all,
}

class TableCalendar extends StatefulWidget {

  final dynamic locale;
  final Map<DateTime, List> events;
  final OnHeader onTitleText;
  final OnHeader onIcon1;
  final OnHeader onIcon2;
  final OnHeader onIcon3;
  final OnDaySelected onDaySelected;
  final VoidCallback onUnavailableDaySelected;
  final OnVisibleDaysChanged onVisibleDaysChanged;
  final DateTime selectedDay;
  final DateTime startDay;
  final DateTime endDay;
  final CalendarFormat initialCalendarFormat;
  final CalendarFormat forcedCalendarFormat;
  final Map<CalendarFormat, String> availableCalendarFormats;
  final bool headerVisible;
  final double rowHeight;
  final bool animateProgSelectedDay;
  final StartingDayOfWeek startingDayOfWeek;
  final HitTestBehavior dayHitTestBehavior;
  final AvailableGestures availableGestures;
  final SimpleSwipeConfig simpleSwipeConfig;
  final CalendarStyle calendarStyle;
  final DaysOfWeekStyle daysOfWeekStyle;
  final HeaderStyle headerStyle;
  final CalendarBuilders builders;

  TableCalendar({
    Key key,
    this.locale,
    this.events = const {},
    this.onDaySelected,
    this.onTitleText,
    this.onIcon1,
    this.onIcon2,
    this.onIcon3,
    this.onUnavailableDaySelected,
    this.onVisibleDaysChanged,
    this.selectedDay,
    this.startDay,
    this.endDay,
    this.initialCalendarFormat = CalendarFormat.month,
    this.forcedCalendarFormat,
    this.availableCalendarFormats = const {
      CalendarFormat.month: 'Month',
      CalendarFormat.week: 'Week',
    },
    this.headerVisible = true,
    this.rowHeight,
    this.animateProgSelectedDay = false,
    this.startingDayOfWeek = StartingDayOfWeek.sunday,
    this.dayHitTestBehavior = HitTestBehavior.deferToChild,
    this.availableGestures = AvailableGestures.all,
    this.simpleSwipeConfig = const SimpleSwipeConfig(
      verticalThreshold: 25.0,
      swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
    ),
    this.calendarStyle = const CalendarStyle(),
    this.daysOfWeekStyle = const DaysOfWeekStyle(),
    this.headerStyle = const HeaderStyle(),
    this.builders = const CalendarBuilders(),
  })  : assert(availableCalendarFormats.keys.contains(initialCalendarFormat)),
        assert(availableCalendarFormats.length <= CalendarFormat.values.length),
        super(key: key);

  @override
  _TableCalendarState createState() => _TableCalendarState();
}

class _TableCalendarState extends State<TableCalendar> with SingleTickerProviderStateMixin {

  CalendarLogic _calendarLogic;

  @override
  void initState() {
    super.initState();
    _calendarLogic = CalendarLogic(
      widget.availableCalendarFormats,
      widget.startingDayOfWeek,
      initialFormat: widget.initialCalendarFormat,
      initialDay: widget.selectedDay,
      onVisibleDaysChanged: widget.onVisibleDaysChanged,
      includeInvisibleDays: widget.calendarStyle.outsideDaysVisible,
    );
  }

  @override
  void didUpdateWidget(TableCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDay != null && widget.selectedDay != null) {
      if (!Utils.isSameDay(oldWidget.selectedDay, widget.selectedDay)) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          setState(() {
            final runCallback = _calendarLogic.setSelectedDay(
              widget.selectedDay,
              isAnimated: widget.animateProgSelectedDay,
              isProgrammatic: true,
            );

            if (runCallback && widget.onDaySelected != null) {
              final key = widget.events.keys.firstWhere(
                (it) => Utils.isSameDay(it, widget.selectedDay),
                orElse: () => null,
              );
              widget.onDaySelected(widget.selectedDay, widget.events[key] ?? []);
            }
          });
        });
      }
    }
  }

  @override
  void dispose() {
    _calendarLogic.dispose();
    super.dispose();
  }

  void _selectPrevious() {
    setState(() {
      _calendarLogic.selectPrevious();
    });
  }

  void _selectNext() {
    setState(() {
      _calendarLogic.selectNext();
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      _calendarLogic.setSelectedDay(date);

      if (widget.onDaySelected != null) {
        final key = widget.events.keys.firstWhere((it) => Utils.isSameDay(it, date), orElse: () => null);
        widget.onDaySelected(date, widget.events[key] ?? []);
      }
    });
  }

  void _onHorizontalSwipe(DismissDirection direction) {
    if (direction == DismissDirection.startToEnd) {
      _selectPrevious();
    } else {
      _selectNext();
    }
  }

  void _onUnavailableDaySelected() {
    if (widget.onUnavailableDaySelected != null) {
      widget.onUnavailableDaySelected();
    }
  }

  bool _isDayUnavailable(DateTime day) {
    return (widget.startDay != null && day.isBefore(widget.startDay)) ||
        (widget.endDay != null && day.isAfter(widget.endDay));
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (widget.headerVisible) {
      children.addAll([
        _buildHeader(),
      ]);
    }

    children.addAll([
      SizedBox(height: 15.0,),
      _buildCalendarContent(),
    ]);

    return ClipRect(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  Widget _buildHeader() {
    var title = GestureDetector(
      onTap: widget.onTitleText,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 35.0,
          ),
          Text(
            widget.headerStyle.titleTextBuilder != null
                ? widget.headerStyle.titleTextBuilder(_calendarLogic.focusedDay, widget.locale)
                : DateFormat.yMMMM(widget.locale).format(_calendarLogic.focusedDay),
            style: widget.headerStyle.titleTextStyle,
          ),
        ],
      ),
    );
    return widget.headerStyle.centerHeaderTitle
      ? PlatformAppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: CustomIconButton(
          icon: widget.headerStyle.leftChevronIcon,
          onTap: _selectPrevious,
          margin: widget.headerStyle.leftChevronMargin,
          padding: widget.headerStyle.leftChevronPadding,
        ),
        title: GestureDetector(
          child: Text(
            widget.headerStyle.titleTextBuilder != null
                ? widget.headerStyle.titleTextBuilder(_calendarLogic.focusedDay, widget.locale)
                : DateFormat.yMMMM(widget.locale).format(_calendarLogic.focusedDay),
            style: widget.headerStyle.titleTextStyle,
          ),
          onTap: widget.onTitleText,
        ),
        android: (_) => MaterialAppBarData(
          brightness: Brightness.light,
          elevation: 0.0,
          centerTitle: true,
          actions: <Widget>[
            CustomIconButton(
              icon: widget.headerStyle.rightChevronIcon,
              onTap: _selectNext,
              margin: widget.headerStyle.rightChevronMargin,
              padding: widget.headerStyle.rightChevronPadding,
            ),
          ],
        ),
        ios: (_) => CupertinoNavigationBarData(
          actionsForegroundColor: Colors.transparent,
          border: Border.all(
            color: Colors.transparent,
            width: 0.0,
            style: BorderStyle.none
          ),
          trailing: CustomIconButton(
            icon: widget.headerStyle.rightChevronIcon,
            onTap: _selectNext,
            margin: widget.headerStyle.rightChevronMargin,
            padding: widget.headerStyle.rightChevronPadding,
          ),
        ),
      )
      : PlatformAppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        android: (_) => MaterialAppBarData(
          brightness: Brightness.light,
          elevation: 0.0,
          title: title,
          actions: <Widget>[
            CustomIconButton(
              icon: widget.headerStyle.rightIcon1,
              onTap: widget.onIcon1 ?? () => print('on Icon 1'),
              margin: widget.headerStyle.rightMargin1,
              padding: widget.headerStyle.rightPadding1,
            ),
            CustomIconButton(
              icon: widget.headerStyle.rightIcon2,
              onTap: widget.onIcon2 ?? () => print('on Icon 2'),
              margin: widget.headerStyle.rightMargin2,
              padding: widget.headerStyle.rightPadding2,
            ),
            CustomIconButton(
              icon: widget.headerStyle.rightIcon3,
              onTap: widget.onIcon3 ?? () => print('on Icon 3'),
              margin: widget.headerStyle.rightMargin3,
              padding: widget.headerStyle.rightPadding3,
            ),
            SizedBox(width: 10.0,),
          ],
        ),
        ios: (_) => CupertinoNavigationBarData(
          actionsForegroundColor: Colors.transparent,
          automaticallyImplyMiddle: false,
          border: Border.all(
            color: Colors.transparent,
            width: 0.0,
            style: BorderStyle.none
          ),
          leading: title,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomIconButton(
                icon: widget.headerStyle.rightIcon1,
                onTap: widget.onIcon1 ?? () => print('on Icon 1'),
                margin: widget.headerStyle.rightMargin1,
                padding: widget.headerStyle.rightPadding1,
              ),
              CustomIconButton(
                icon: widget.headerStyle.rightIcon2,
                onTap: widget.onIcon2 ?? () => print('on Icon 2'),
                margin: widget.headerStyle.rightMargin2,
                padding: widget.headerStyle.rightPadding2,
              ),
              CustomIconButton(
                icon: widget.headerStyle.rightIcon3,
                onTap: widget.onIcon3 ?? () => print('on Icon 3'),
                margin: widget.headerStyle.rightMargin3,
                padding: widget.headerStyle.rightPadding3,
              ),
              SizedBox(width: 10.0,),
            ],
          ),
        ),
      );
  }

  Widget _buildCalendarContent() {
    return AnimatedSize(
      duration: Duration(milliseconds: _calendarLogic.calendarFormat == CalendarFormat.month ? 330 : 220),
      curve: Curves.fastOutSlowIn,
      alignment: Alignment(0, -1),
      vsync: this,
      child: _buildWrapper(),
    );
  }

  Widget _buildWrapper({Key key}) {
    Widget wrappedChild = _buildTable();
    switch (widget.availableGestures) {
      case AvailableGestures.all:
        wrappedChild = _buildVerticalSwipeWrapper(
          child: _buildHorizontalSwipeWrapper(
            child: wrappedChild,
          ),
        );
        break;
      case AvailableGestures.verticalSwipe:
        wrappedChild = _buildVerticalSwipeWrapper(
          child: wrappedChild,
        );
        break;
      case AvailableGestures.horizontalSwipe:
        wrappedChild = _buildHorizontalSwipeWrapper(
          child: wrappedChild,
        );
        break;
      case AvailableGestures.none:
        break;
    }
    return Container(
      key: key,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: wrappedChild,
    );
  }

  Widget _buildVerticalSwipeWrapper({Widget child}) {
    return SimpleGestureDetector(
      child: child,
      onVerticalSwipe: (direction) {
        setState(() {
          _calendarLogic.swipeCalendarFormat(direction == SwipeDirection.up);
        });
      },
      swipeConfig: widget.simpleSwipeConfig,
    );
  }

  Widget _buildHorizontalSwipeWrapper({Widget child}) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 350),
      switchInCurve: Curves.decelerate,
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(begin: Offset(_calendarLogic.dx, 0), end: Offset(0, 0)).animate(animation),
          child: child,
        );
      },
      layoutBuilder: (currentChild, _) => currentChild,
      child: Dismissible(
        key: ValueKey(_calendarLogic.pageId),
        resizeDuration: null,
        onDismissed: _onHorizontalSwipe,
        direction: DismissDirection.horizontal,
        child: child,
      ),
    );
  }

  Widget _buildTable() {
    final daysInWeek = 7;
    final children = <TableRow>[
      _buildDaysOfWeek(),
    ];
    int x = 0;
    while (x < _calendarLogic.visibleDays.length) {
      children.add(_buildTableRow(_calendarLogic.visibleDays.skip(x).take(daysInWeek).toList()));
      x += daysInWeek;
    }
    return Table(
      defaultColumnWidth: FractionColumnWidth(1.0 / daysInWeek),
      children: children,
    );
  }

  TableRow _buildDaysOfWeek() {
    return TableRow(
      children: _calendarLogic.visibleDays.take(7).map((date) {
        return Center(
          child: Text(
            widget.daysOfWeekStyle.dowTextBuilder != null
                ? widget.daysOfWeekStyle.dowTextBuilder(date, widget.locale)
                : DateFormat.E(widget.locale).format(date),
            style: _calendarLogic.isWeekend(date)
                ? widget.daysOfWeekStyle.weekendStyle
                : widget.daysOfWeekStyle.weekdayStyle,
          ),
        );
      }).toList(),
    );
  }

  TableRow _buildTableRow(List<DateTime> days) {
    return TableRow(children: days.map((date) => _buildTableCell(date)).toList());
  }

  Widget _buildTableCell(DateTime date) {
    return LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: widget.rowHeight ?? constraints.maxWidth,
          minHeight: widget.rowHeight ?? constraints.maxWidth,
        ),
        child: _buildCell(date),
      ),
    );
  }

  Widget _buildCell(DateTime date) {
    if (!widget.calendarStyle.outsideDaysVisible &&
        _calendarLogic.isExtraDay(date) &&
        _calendarLogic.calendarFormat == CalendarFormat.month) {
      return Container();
    }
    Widget content = _buildCellContent(date);
    final eventKey = widget.events.keys.firstWhere((it) => Utils.isSameDay(it, date), orElse: () => null);
    if (eventKey != null) {
      final children = <Widget>[content];
      final events = eventKey != null ? widget.events[eventKey].take(widget.calendarStyle.markersMaxAmount) : [];
      if (!_isDayUnavailable(date)) {
        if (widget.builders.markersBuilder != null) {
          children.addAll(
            widget.builders.markersBuilder(
              context,
              eventKey,
              events.toList(),
            ),
          );
        }
      }
      if (children.length > 1) {
        content = Stack(
          alignment: widget.calendarStyle.markersAlignment,
          children: children,
          overflow: widget.calendarStyle.canEventMarkersOverflow ? Overflow.visible : Overflow.clip,
        );
      }
    }
    return GestureDetector(
      behavior: widget.dayHitTestBehavior,
      onTap: () => _isDayUnavailable(date) ? _onUnavailableDaySelected() : _selectDate(date),
      child: content,
    );
  }

  Widget _buildCellContent(DateTime date) {
    final eventKey = widget.events.keys.firstWhere((it) => Utils.isSameDay(it, date), orElse: () => null);
    final tIsUnavailable = _isDayUnavailable(date);
    final tIsSelected = _calendarLogic.isSelected(date);
    final tIsToday = _calendarLogic.isToday(date);
    final tIsOutside = _calendarLogic.isExtraDay(date);
    final tIsWeekend = _calendarLogic.isWeekend(date);
    final isUnavailable = widget.builders.unavailableDayBuilder != null && tIsUnavailable;
    final isSelected = widget.builders.selectedDayBuilder != null && tIsSelected;
    final isToday = widget.builders.todayDayBuilder != null && tIsToday;
    final isOutsideWeekend = widget.builders.outsideWeekendDayBuilder != null && tIsOutside && tIsWeekend;
    final isOutside = widget.builders.outsideDayBuilder != null && tIsOutside && !tIsWeekend;
    final isWeekend = widget.builders.weekendDayBuilder != null && !tIsOutside && tIsWeekend;
    if (isUnavailable) {
      return widget.builders.unavailableDayBuilder(context, date, widget.events[eventKey]);
    } else if (isSelected && widget.calendarStyle.renderSelectedFirst) {
      return widget.builders.selectedDayBuilder(context, date, widget.events[eventKey]);
    } else if (isToday) {
      return widget.builders.todayDayBuilder(context, date, widget.events[eventKey]);
    } else if (isSelected) {
      return widget.builders.selectedDayBuilder(context, date, widget.events[eventKey]);
    } else if (isOutsideWeekend) {
      return widget.builders.outsideWeekendDayBuilder(context, date, widget.events[eventKey]);
    } else if (isOutside) {
      return widget.builders.outsideDayBuilder(context, date, widget.events[eventKey]);
    } else if (isWeekend) {
      return widget.builders.weekendDayBuilder(context, date, widget.events[eventKey]);
    } else if (widget.builders.dayBuilder != null) {
      return widget.builders.dayBuilder(context, date, widget.events[eventKey]);
    } else {
      return CellWidget(
        text: '${date.day}',
        isUnavailable: tIsUnavailable,
        isSelected: tIsSelected,
        isToday: tIsToday,
        isWeekend: tIsWeekend,
        isOutsideMonth: tIsOutside,
        calendarStyle: widget.calendarStyle,
      );
    }
  }

}
