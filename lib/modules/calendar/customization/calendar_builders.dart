part of calendar;

class CalendarBuilders {

  final FullBuilder dayBuilder;
  final FullBuilder selectedDayBuilder;
  final FullBuilder todayDayBuilder;
  final FullBuilder weekendDayBuilder;
  final FullBuilder outsideDayBuilder;
  final FullBuilder outsideWeekendDayBuilder;
  final FullBuilder unavailableDayBuilder;
  final FullListBuilder markersBuilder;
  final DowBuilder dowWeekdayBuilder;
  final DowBuilder dowWeekendBuilder;

  const CalendarBuilders({
    this.dayBuilder,
    this.selectedDayBuilder,
    this.todayDayBuilder,
    this.weekendDayBuilder,
    this.outsideDayBuilder,
    this.outsideWeekendDayBuilder,
    this.unavailableDayBuilder,
    this.markersBuilder,
    this.dowWeekdayBuilder,
    this.dowWeekendBuilder,
  });

}
