import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show SizeConfig;
import 'package:long_life_burning/modules/calendar/calendar.dart';

typedef void OnDaySelected(DateTime day, List events);
typedef void OnVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format);
typedef void OnHeader();

class Calendar extends StatelessWidget {

  final CalendarController controller;
  final Map<DateTime, List> records;
  final OnDaySelected onDaySelected;
  final OnHeader onTitleText;
  final OnVisibleDaysChanged onVisibleDaysChanged;

  Calendar({
    Key key,
    @required this.controller,
    this.records,
    this.onDaySelected,
    this.onTitleText,
    this.onVisibleDaysChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: controller,
      locale: 'en_US',
      events: records,
      initialCalendarFormat: CalendarFormat.week,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.none,
      availableCalendarFormats: {
        CalendarFormat.week: 'Week',
      },
      onDaySelected: onDaySelected,
      onTitleText: onTitleText,
      onVisibleDaysChanged: onVisibleDaysChanged,
      markerVisible: false,
      calendarStyle: CalendarStyle(
        outsideStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
        outsideWeekendStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,),
        weekdayStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
        weekendStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextBuilder: (date, locale) => SizeConfig.screenWidth < 400
            ? DateFormat.E(locale).format(date).substring(0, 1).toUpperCase()
            : DateFormat.E(locale).format(date).substring(0, 3).toUpperCase(),
        weekdayStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
        weekendStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        beforeIcon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: SizeConfig.setWidth(28.0),
        ),
        nextIcon: Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
          size: SizeConfig.setWidth(28.0),
        ),
        beforePadding: EdgeInsets.all(SizeConfig.setWidth(12.0)),
        nextPadding: EdgeInsets.all(SizeConfig.setWidth(12.0)),
        beforeMargin: EdgeInsets.symmetric(
          horizontal: SizeConfig.setWidth(8.0),
        ),
        nextMargin: EdgeInsets.symmetric(
          horizontal: SizeConfig.setWidth(8.0),
        ),
      ),
      builders: CalendarBuilders(
        todayDayBuilder: (context, date, events) {
          return Center(
            child: Text(
              '${date.day}',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
        selectedDayBuilder: (context, date, events) {
          return Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color:  controller.isToday(date) ? Colors.red : Colors.black,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}