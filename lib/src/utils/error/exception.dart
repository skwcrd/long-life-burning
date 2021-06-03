part of util;

class InstanceException implements Exception {
  InstanceException({
    required this.className,
    this.message,
    this.details,
  });

  final String className;
  final String? message;
  final dynamic details;

  @override
  String toString() => details == null
      ? "InstanceException on $className: $message"
      : "InstanceException on $className: $message, details: $details";
}