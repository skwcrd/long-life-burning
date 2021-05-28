part of util;

enum GroupType {
  Run,
  Football,
  Basketball,
  Volleyball,
  Other,
}

extension GroupTypeDescription on GroupType {
  String get value {
    switch (this) {
      case GroupType.Run:
        return 'run';

      case GroupType.Football:
        return 'football';

      case GroupType.Basketball:
        return 'basketball';

      case GroupType.Volleyball:
        return 'volleyball';

      case GroupType.Other:
        return 'other';

      default:
        return 'unknown';
    }
  }

  String get text {
    switch (this) {
      case GroupType.Run:
        return 'Run';

      case GroupType.Football:
        return 'Football';

      case GroupType.Basketball:
        return 'Basketball';

      case GroupType.Volleyball:
        return 'Volleyball';

      case GroupType.Other:
        return 'Other';

      default:
        return 'unknown';
    }
  }
}

extension GroupTypeCompare on GroupType {
  bool get isRun =>
      this == GroupType.Run;
  bool get isFootball =>
      this == GroupType.Football;
  bool get isBasketball =>
      this == GroupType.Basketball;
  bool get isVolleyball =>
      this == GroupType.Volleyball;
  bool get isOther =>
      this == GroupType.Other;

  bool get isNotRun =>
      this != GroupType.Run;
  bool get isNotFootball =>
      this != GroupType.Football;
  bool get isNotBasketball =>
      this != GroupType.Basketball;
  bool get isNotVolleyball =>
      this != GroupType.Volleyball;
  bool get isNotOther =>
      this != GroupType.Other;
}