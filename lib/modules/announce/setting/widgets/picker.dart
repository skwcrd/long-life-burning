part of settings;

class CusttomPicker extends StatefulWidget {

  final List<String> items;
  final String title;
  final int currentIndex;
  final SelectionCallback onSelect;

  CusttomPicker({
    Key key,
    @required this.items,
    this.title,
    this.currentIndex = 0,
    this.onSelect,
  }) :  assert(items != null),
        assert(0 <= currentIndex && currentIndex < items.length),
        super(key: key);

  @override
  _CusttomPickerState createState() => _CusttomPickerState();
}

class _CusttomPickerState extends State<CusttomPicker> {

  FixedExtentScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: widget.currentIndex);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scrollController = FixedExtentScrollController(initialItem: widget.currentIndex);
    return Container(
      height: SETTING_ITEM_HEIGHT,
      padding: SETTING_ITEM_PADDING,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: SETTING_BORDER_COLOR,
            width: 1.0,
          ),
        ),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async => await showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => _buildBottomPicker(
                  CupertinoPicker(
                    scrollController: scrollController,
                    itemExtent: _kPickerItemHeight,
                    backgroundColor: Colors.white,
                    onSelectedItemChanged: widget.onSelect,
                    children: List<Widget>.generate(widget.items.length, (int index) {
                      return Center(
                        child: Text(widget.items[index]),
                      );
                    }),
                  ),
                  title: widget.title ?? ' ',
                  context: context,
                ),
              ),
              child: _buildMenu(
                <Widget>[
                  Text(
                    widget.title ?? ' ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.items[widget.currentIndex],
                    style: TextStyle(
                      color: CupertinoColors.inactiveGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class TimerPicker extends StatelessWidget {

  final String title;
  final Duration currentTimer;
  final TimerCallback onSelect;

  TimerPicker({
    Key key,
    this.title,
    this.currentTimer,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SETTING_ITEM_HEIGHT,
      padding: SETTING_ITEM_PADDING,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: SETTING_BORDER_COLOR,
            width: 1.0,
          ),
        ),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async => await showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => _buildBottomPicker(
                  CupertinoTimerPicker(
                    initialTimerDuration: currentTimer ?? Duration.zero,
                    mode: CupertinoTimerPickerMode.hms,
                    onTimerDurationChanged: onSelect,
                  ),
                  title: title ?? ' ',
                  context: context,
                ),
              ),
              child: _buildMenu(
                <Widget>[
                  Text(
                    title ?? ' ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${(currentTimer.inHours).toString().padLeft(2,'0')}:'
                    '${(currentTimer.inMinutes % 60).toString().padLeft(2,'0')}:'
                    '${(currentTimer.inSeconds % 60).toString().padLeft(2,'0')}',
                    style: TextStyle(
                      color: CupertinoColors.inactiveGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class DatePicker extends StatelessWidget {

  final String title;
  final DateTime currentDate;
  final DateCallback onSelect;

  DatePicker({
    Key key,
    this.title,
    this.currentDate,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SETTING_ITEM_HEIGHT,
      padding: SETTING_ITEM_PADDING,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: SETTING_BORDER_COLOR,
            width: 1.0,
          ),
        ),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async => await showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => _buildBottomPicker(
                  CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: currentDate ?? DateTime.now(),
                    onDateTimeChanged: onSelect,
                    use24hFormat: true,
                  ),
                  title: title ?? ' ',
                  context: context,
                ),
              ),
              child: _buildMenu(
                <Widget>[
                  Text(
                    title ?? ' ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMMd().format(currentDate),
                    style: const TextStyle(color: CupertinoColors.inactiveGray),
                  ),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class TimePicker extends StatelessWidget {

  final String title;
  final DateTime currentTime;
  final DateCallback onSelect;

  TimePicker({
    Key key,
    this.title,
    this.currentTime,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SETTING_ITEM_HEIGHT,
      padding: SETTING_ITEM_PADDING,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: SETTING_BORDER_COLOR,
            width: 1.0,
          ),
        ),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async => await showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => _buildBottomPicker(
                  CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: currentTime ?? DateTime.now(),
                    onDateTimeChanged: onSelect,
                    use24hFormat: true,
                  ),
                  title: title ?? ' ',
                  context: context,
                ),
              ),
              child: _buildMenu(
                <Widget>[
                  Text(
                    title ?? ' ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    DateFormat.Hm().format(currentTime ?? DateTime.now()),
                    style: TextStyle(
                      color: CupertinoColors.inactiveGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class DateAndTimePicker extends StatelessWidget {

  final String title;
  final DateTime currentDateAndTime;
  final DateCallback onSelect;

  DateAndTimePicker({
    Key key,
    this.title,
    this.currentDateAndTime,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SETTING_ITEM_HEIGHT,
      padding: SETTING_ITEM_PADDING,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: SETTING_BORDER_COLOR,
            width: 1.0,
          ),
        ),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async => await showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => _buildBottomPicker(
                  CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: currentDateAndTime ?? DateTime.now(),
                    onDateTimeChanged: onSelect,
                    use24hFormat: true,
                  ),
                  title: title ?? ' ',
                  context: context,
                ),
              ),
              child: _buildMenu(
                <Widget>[
                  Text(
                    title ?? ' ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMMd().add_Hm().format(currentDateAndTime),
                    style: const TextStyle(color: CupertinoColors.inactiveGray),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

Widget _buildMenu(List<Widget> children) {
  return Container(
    alignment: AlignmentDirectional.centerStart,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    ),
  );
}

Widget _buildBottomPicker(Widget picker, {String title, BuildContext context}) {
  return Container(
    height: _kPickerSheetHeight,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(18.0),
        topRight: Radius.circular(18.0),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: DefaultTextStyle(
            style: TextStyle(
              color: CupertinoColors.inactiveGray,
              fontSize: 18.0,
            ),
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                top: 18.0,
                left: 24.0,
                right: 24.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(title),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: CupertinoColors.activeBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
            ),
            child: GestureDetector(
              onTap: () { },
              child: SafeArea(
                child: picker,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
