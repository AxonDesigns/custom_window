import 'package:flutter/material.dart';

class TitleBarButton extends StatefulWidget {
  final Widget? child;
  final VoidCallback? onPressed;
  final Size? minSize;
  final Size? maxSize;
  final EdgeInsetsGeometry padding;
  final Color? inactiveColor;
  final Color? activeColor;
  final Color? hoveredColor;
  final Color? disableColor;
  final Widget Function(bool pressed, bool hovered, bool enabled)? childBuilder;

  const TitleBarButton({
    super.key,
    this.child,
    this.childBuilder,
    this.onPressed,
    this.minSize,
    this.maxSize,
    this.inactiveColor,
    this.hoveredColor,
    this.activeColor,
    this.disableColor,
    this.padding = const EdgeInsets.all(9),
  }) : assert(
          (child == null && childBuilder != null) || (childBuilder == null && child != null) || (childBuilder == null && child == null),
        );

  @override
  State<TitleBarButton> createState() => _TitleBarButtonState();
}

class _TitleBarButtonState extends State<TitleBarButton> {
  bool pressed = false;
  bool hovered = false;

  bool get isEnabled {
    return widget.onPressed != null;
  }

  @override
  Widget build(BuildContext context) {
    final targetBgColor = !isEnabled
        ? widget.disableColor ?? Theme.of(context).colorScheme.onBackground.withOpacity(0.0)
        : pressed
            ? widget.activeColor ?? Theme.of(context).colorScheme.onBackground.withOpacity(0.025)
            : hovered
                ? widget.hoveredColor ?? Theme.of(context).colorScheme.onBackground.withOpacity(0.05)
                : widget.inactiveColor ?? Theme.of(context).colorScheme.onBackground.withOpacity(0.0);

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
            maxHeight: widget.maxSize?.height ?? double.infinity,
            maxWidth: widget.maxSize?.width ?? double.infinity,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: targetBgColor,
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
