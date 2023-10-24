import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowScaffold extends StatefulWidget {
  final Widget Function(bool maximized, bool focused) body;
  final Widget Function(bool maximized, bool focused)? titleBar;
  final Color? titleBarColor;
  final Color? BackgroundColor;
  const WindowScaffold({
    super.key,
    required this.body,
    this.titleBar,
    this.titleBarColor,
    this.BackgroundColor,
  });

  @override
  State<StatefulWidget> createState() => _WindowScaffoldState();
}

class _WindowScaffoldState extends State<WindowScaffold> with WindowListener {
  bool isMaximized = false;
  bool isFocused = true;
  String title = "";

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    setState(() {
      windowManager.getTitle().then((value) => setState(() => title = value));
    });
  }

  @override
  void didUpdateWidget(covariant WindowScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Material(
        color: widget.BackgroundColor ?? Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            if (widget.titleBar != null) widget.titleBar!.call(isMaximized, isFocused),
            Expanded(child: widget.body(isMaximized, isFocused)),
          ],
        ),
      ),
    );
  }

  @override
  void onWindowFocus() {
    super.onWindowFocus();
    setState(() {
      isFocused = true;
    });
  }

  @override
  void onWindowBlur() {
    super.onWindowBlur();
    setState(() {
      isFocused = false;
    });
  }

  @override
  void onWindowMaximize() {
    super.onWindowMaximize();
    setState(() {
      isMaximized = true;
    });
  }

  @override
  void onWindowUnmaximize() {
    super.onWindowMinimize();
    setState(() {
      isMaximized = false;
    });
  }

  @override
  void onWindowUndocked() {
    super.onWindowUndocked();
    isMaximized = false;
  }

  @override
  void onWindowMinimize() {
    super.onWindowMinimize();
    isFocused = false;
  }

  @override
  void onWindowRestore() {
    super.onWindowRestore();
    setState(() {
      isFocused = true;
    });
  }
}
