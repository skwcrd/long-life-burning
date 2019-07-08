import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/calendar/utils/dates.dart';
import 'package:long_life_burning/modules/calendar/utils/screen_sizes.dart';
import 'package:long_life_burning/modules/calendar/month/month_title.dart';
import 'package:long_life_burning/modules/calendar/day/day_number.dart';

class MonthView extends StatelessWidget {
  const MonthView({
    @required this.context,
    @required this.year,
    @required this.month,
    @required this.padding,
    this.isTomonth,
    this.todayColor,
    this.monthNames,
    this.onMonthTap,
  });

  final BuildContext context;
  final int year;
  final int month;
  final double padding;
  final bool isTomonth;
  final Color todayColor;
  final List<String> monthNames;
  final Function onMonthTap;

  Widget buildMonthDays(BuildContext context) {
    final List<Row> dayRows = <Row>[];
    final List<DayNumber> dayRowChildren = <DayNumber>[];

    final int daysInMonth = getDaysInMonth(year, month);
    final int firstWeekdayOfMonth = DateTime(year, month, 1).weekday;

    for (int day = 2 - firstWeekdayOfMonth; day <= daysInMonth; day++) {
      final bool isToday = dateIsToday(DateTime(year, month, day));
      dayRowChildren.add(
        DayNumber(
          day: day,
          isToday: isToday,
          todayColor: todayColor,
        ),
      );

      if ((day - 1 + firstWeekdayOfMonth) % DateTime.daysPerWeek == 0 ||
          day == daysInMonth) {
        dayRows.add(
          Row(
            children: List<DayNumber>.from(dayRowChildren),
          ),
        );
        dayRowChildren.clear();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dayRows,
    );
  }

  Widget buildMonthView(BuildContext context) {
    return Container(
      width: 7 * getDayNumberSize(context),
      margin: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MonthTitle(
            month: month,
            monthNames: monthNames,
            isTomonth: isTomonth,
            tomonthColor: todayColor,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: buildMonthDays(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return onMonthTap == null
      ? Container(
          child: buildMonthView(context),
        )
      : InkWell(
          onTap: () => this.onMonthTap(year, month),
          child: buildMonthView(context),
        );
  }
}
