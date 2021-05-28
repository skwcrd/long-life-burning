part of util;

enum EventType {
  All,
  FunRun,
  MiniMarathon,
  HalfMarathon,
  Marathon,
}

extension EventTypeDescription on EventType {
  String get value {
    switch (this) {
      case EventType.All:
        return 'all';

      case EventType.FunRun:
        return 'fun-run';

      case EventType.MiniMarathon:
        return 'mini-marathon';

      case EventType.HalfMarathon:
        return 'half-marathon';

      case EventType.Marathon:
        return 'marathon';

      default:
        return 'unknown';
    }
  }

  String get text {
    switch (this) {
      case EventType.All:
        return 'All Category';

      case EventType.FunRun:
        return 'Fun Run';

      case EventType.MiniMarathon:
        return 'Mini Marathon';

      case EventType.HalfMarathon:
        return 'Half Marathon';

      case EventType.Marathon:
        return 'Marathon';

      default:
        return 'unknown';
    }
  }
}

extension EventTypeCompare on EventType {
  bool get isAll =>
      this == EventType.All;
  bool get isFunRun =>
      this == EventType.FunRun;
  bool get isMiniMarathon =>
      this == EventType.MiniMarathon;
  bool get isHalfMarathon =>
      this == EventType.HalfMarathon;
  bool get isMarathon =>
      this == EventType.Marathon;

  bool get isNotAll =>
      this != EventType.All;
  bool get isNotFunRun =>
      this != EventType.FunRun;
  bool get isNotMiniMarathon =>
      this != EventType.MiniMarathon;
  bool get isNotHalfMarathon =>
      this != EventType.HalfMarathon;
  bool get isNotMarathon =>
      this != EventType.Marathon;
}