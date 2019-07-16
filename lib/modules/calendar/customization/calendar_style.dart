import 'package:flutter/material.dart';

class CalendarStyle {
  
  final TextStyle weekdayStyle;
  final TextStyle weekendStyle;
  final TextStyle selectedStyle;
  final TextStyle todayStyle;
  final TextStyle outsideStyle;
  final TextStyle outsideWeekendStyle;
  final TextStyle unavailableStyle;
  final Color selectedColor;
  final Color todayColor;
  final Color markersColor;
  final Alignment markersAlignment;
  final double markersPositionTop;
  final double markersPositionBottom;
  final double markersPositionLeft;
  final double markersPositionRight;
  final int markersMaxAmount;
  final bool outsideDaysVisible;
  final bool renderSelectedFirst;
  final bool canEventMarkersOverflow;

  const CalendarStyle({
    this.weekdayStyle = const TextStyle(),
    this.weekendStyle = const TextStyle(color: const Color(0xFFF44336)), // Material red[500]
    this.selectedStyle = const TextStyle(color: const Color(0xFFFAFAFA), fontSize: 16.0), // Material grey[50]
    this.todayStyle = const TextStyle(color: const Color(0xFFFAFAFA), fontSize: 16.0), // Material grey[50]
    this.outsideStyle = const TextStyle(color: const Color(0xFF9E9E9E)), // Material grey[500]
    this.outsideWeekendStyle = const TextStyle(color: const Color(0xFFEF9A9A)), // Material red[200]
    this.unavailableStyle = const TextStyle(color: const Color(0xFFBFBFBF)),
    this.selectedColor = const Color(0xFF5C6BC0), // Material indigo[400]
    this.todayColor = const Color(0xFF9FA8DA), // Material indigo[200]
    this.markersColor = const Color(0xFF263238), // Material blueGrey[900]
    this.markersAlignment = Alignment.bottomCenter,
    this.markersPositionTop,
    this.markersPositionBottom = 5.0,
    this.markersPositionLeft,
    this.markersPositionRight,
    this.markersMaxAmount = 4,
    this.outsideDaysVisible = true,
    this.renderSelectedFirst = true,
    this.canEventMarkersOverflow = false,
  });
  
}
