part of layout;

double _textScaleFactor(BuildContext context) =>
    MediaQuery.of(context).textScaleFactor;

/// When text is larger, this factor becomes larger, but at half the rate.
///
/// | Text scaling | Text scale factor | reducedTextScale(context) |
/// |--------------|-------------------|---------------------------|
/// | Small        |               0.8 |                       1.0 |
/// | Normal       |               1.0 |                       1.0 |
/// | Large        |               2.0 |                       1.5 |
/// | Huge         |               3.0 |                       2.0 |
double reducedTextScale(BuildContext context) {
  final textScaleFactor = _textScaleFactor(context);
  return textScaleFactor >= 1 ? (1 + textScaleFactor) / 2 : 1;
}

/// When text is larger, this factor becomes larger at the same rate.
/// But when text is smaller, this factor stays at 1.
///
/// | Text scaling | Text scale factor |  cappedTextScale(context) |
/// |--------------|-------------------|---------------------------|
/// | Small        |               0.8 |                       1.0 |
/// | Normal       |               1.0 |                       1.0 |
/// | Large        |               2.0 |                       2.0 |
/// | Huge         |               3.0 |                       3.0 |
double cappedTextScale(BuildContext context) {
  final textScaleFactor = _textScaleFactor(context);
  return math.max(textScaleFactor, 1);
}