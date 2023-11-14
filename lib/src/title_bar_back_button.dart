import 'package:flutter/material.dart';

class TitleBarBackButton extends StatefulWidget {
  final Widget? child;
  final VoidCallback? onPressed;
  final Size? minSize;
  final EdgeInsetsGeometry padding;
  final Widget Function(bool pressed, bool hovered, bool enabled)? childBuilder;
  const TitleBarBackButton({
    super.key,
    this.child,
    this.childBuilder,
    this.onPressed,
    this.minSize,
    this.padding = const EdgeInsets.all(9),
  }) : assert(
          (child == null && childBuilder != null) || (childBuilder == null && child != null) || (childBuilder == null && child == null),
        );

  factory TitleBarBackButton.builder({required Widget child, VoidCallback? onPressed}) {
    return TitleBarBackButton(
      onPressed: onPressed,
      child: child,
    );
  }

  @override
  State<TitleBarBackButton> createState() => _TitleBarBackButtonState();
}

class _TitleBarBackButtonState extends State<TitleBarBackButton> {
  bool pressed = false;
  bool hovered = false;

  bool get isEnabled {
    return widget.onPressed != null;
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      onShowHoverHighlight: (value) => setState(() => hovered = value),
      child: GestureDetector(
        onTapDown: isEnabled ? (details) => setState(() => pressed = true) : null,
        onTapCancel: () => setState(() => pressed = false),
        onTapUp: (details) => setState(() => pressed = false),
        onTap: widget.onPressed,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: widget.minSize?.width ?? 15,
            minHeight: widget.minSize?.height ?? 15,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.onBackground.withOpacity(isEnabled
                  ? pressed
                      ? 0.025
                      : hovered
                          ? 0.05
                          : 0.0
                  : 0.0),
            ),
            child: Padding(
              padding: widget.padding,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                opacity: !isEnabled ? 0.4 : 1.0,
                child: widget.childBuilder?.call(pressed, hovered, isEnabled) ?? widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
