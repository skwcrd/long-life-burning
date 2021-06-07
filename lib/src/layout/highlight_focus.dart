part of layout;

/// [HighlightFocus] is a helper widget for giving a child focus
/// allowing tab-navigation.
/// Wrap your widget as [child] of a [HighlightFocus] widget.
class HighlightFocus extends StatelessWidget {
  HighlightFocus({
    required this.onPressed,
    required this.child,
    Key? key,
    this.highlightColor,
    this.borderColor,
    this.hasFocus = true,
    this.debugLabel,
  }) :  _isFocused = false.obs,
        super(key: key);

  /// [onPressed] is called when you press space, enter, or numpad-enter
  /// when the widget is focused.
  final VoidCallback onPressed;

  /// [child] is your widget.
  final Widget child;

  /// [highlightColor] is the color filled in the border when the widget
  /// is focused.
  /// Use [Colors.transparent] if you do not want one.
  /// Use an opacity less than 1 to make the underlying widget visible.
  final Color? highlightColor;

  /// [borderColor] is the color of the border when the widget is focused.
  final Color? borderColor;

  /// [hasFocus] is true when focusing on the widget is allowed.
  /// Set to false if you want the child to skip focus.
  final bool hasFocus;

  final String? debugLabel;

  final RxBool _isFocused;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('debugLabel', debugLabel))
      ..add(ColorProperty('borderColor', borderColor))
      ..add(ColorProperty('highlightColor', highlightColor))
      ..add(DiagnosticsProperty<bool>('hasFocus', hasFocus))
      ..add(ObjectFlagProperty<VoidCallback>.has('onPressed', onPressed));
  }

  @override
  Widget build(BuildContext context) =>
    Focus(
      debugLabel: debugLabel,
      canRequestFocus: hasFocus,
      onFocusChange: _isFocused,
      onKey: (node, event) {
        if (event is RawKeyDownEvent && (
            event.logicalKey == LogicalKeyboardKey.space ||
            event.logicalKey == LogicalKeyboardKey.enter ||
            event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
          onPressed();
          return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      child: Obx(
        () => Container(
          foregroundDecoration: _isFocused.value
            ? BoxDecoration(
                color: highlightColor
                  ?? Get.theme.colorScheme.primary.withOpacity(0.5),
                border: Border.all(
                  color: borderColor
                    ?? Get.theme.colorScheme.onPrimary,
                  width: 2,
                ),
              )
            : null,
          child: child,
        ),
      ),
    );
}