import 'package:custom_window/custom_window.dart';
import 'package:flutter/material.dart';

class WindowScaffold extends StatefulWidget {
  final Widget Function(bool maximized, bool focused) bodyBuilder;
  final Widget Function(bool maximized, bool focused)? titleBarBuilder;
  final Color? titleBarColor;
  final Color? BackgroundColor;
  const WindowScaffold({
    super.key,
    required this.bodyBuilder,
    this.titleBarBuilder,
    this.titleBarColor,
    this.BackgroundColor,
  });

  @override
  State<StatefulWidget> createState() => _WindowScaffoldState();
}

class _WindowScaffoldState extends State<WindowScaffold> {
  bool _isMaximized = false;
  bool _isFocused = true;

  @override
  void initState() {
    customWindow.isMaximized.then((value) => setState(() => _isMaximized = value));
    customWindow.isFocused.then((value) => setState(() => _isFocused = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WindowCallbackContainer(
      onFocus: () => setState(() => _isFocused = true),
      onUnFocus: () => setState(() => _isFocused = false),
      onMaximize: () => setState(() => _isMaximized = true),
      onUnMaximize: () => setState(() => _isMaximized = false),
      onMinimize: () => setState(() => _isFocused = false),
      onRestore: () => setState(() => _isFocused = true),
      child: Builder(
        builder: (context) => Material(
          color: widget.BackgroundColor ?? Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              if (widget.titleBarBuilder != null) widget.titleBarBuilder!.call(_isMaximized, _isFocused),
              Expanded(child: widget.bodyBuilder(_isMaximized, _isFocused)),
            ],
          ),
        ),
      ),
    );
  }
}
