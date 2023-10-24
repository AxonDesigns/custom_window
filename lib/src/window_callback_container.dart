import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowCallbackContainer extends StatefulWidget {
  final VoidCallback? onClose;
  final VoidCallback? onMinimize;
  final VoidCallback? onMaximize;
  final VoidCallback? onUnMaximize;
  final VoidCallback? onFocus;
  final VoidCallback? onUnFocus;
  final VoidCallback? onDocked;
  final VoidCallback? onUnDocked;
  final VoidCallback? onMove;
  final VoidCallback? onMoved;
  final VoidCallback? onResize;
  final VoidCallback? onResized;
  final VoidCallback? onRestore;
  final VoidCallback? onEnterFullScreen;
  final VoidCallback? onLeaveFullScreen;
  final Widget child;
  final Function(String event)? onEvent;

  const WindowCallbackContainer({
    super.key,
    this.onClose,
    this.onMinimize,
    this.onMaximize,
    this.onUnMaximize,
    this.onFocus,
    this.onUnFocus,
    this.onDocked,
    this.onUnDocked,
    this.onMove,
    this.onMoved,
    this.onResize,
    this.onResized,
    this.onRestore,
    this.onEnterFullScreen,
    this.onLeaveFullScreen,
    this.onEvent,
    required this.child,
  });

  @override
  State<WindowCallbackContainer> createState() => _WindowCallbackContainerState();
}

class _WindowCallbackContainerState extends State<WindowCallbackContainer> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  void onWindowClose() {
    super.onWindowClose();
    widget.onClose?.call();
  }

  @override
  void onWindowBlur() {
    super.onWindowBlur();
    widget.onUnFocus?.call();
  }

  @override
  void onWindowMinimize() {
    super.onWindowMinimize();
    widget.onMinimize?.call();
  }

  @override
  void onWindowMove() {
    super.onWindowMove();
    widget.onMove?.call();
  }

  @override
  void onWindowMoved() {
    super.onWindowMoved();
    widget.onMoved?.call();
  }

  @override
  void onWindowMaximize() {
    super.onWindowMaximize();
    widget.onMaximize?.call();
  }

  @override
  void onWindowFocus() {
    super.onWindowFocus();
    widget.onFocus?.call();
  }

  @override
  void onWindowUnmaximize() {
    super.onWindowUnmaximize();
    widget.onUnMaximize?.call();
  }

  @override
  void onWindowResize() {
    super.onWindowResize();
    widget.onResize?.call();
  }

  @override
  void onWindowResized() {
    super.onWindowResized();
    widget.onResized?.call();
  }

  @override
  void onWindowRestore() {
    super.onWindowRestore();
    widget.onRestore?.call();
  }

  @override
  void onWindowDocked() {
    super.onWindowDocked();
    widget.onDocked?.call();
  }

  @override
  void onWindowUndocked() {
    super.onWindowUndocked();
    widget.onUnDocked?.call();
  }

  @override
  void onWindowEnterFullScreen() {
    super.onWindowEnterFullScreen();
    widget.onEnterFullScreen?.call();
  }

  @override
  void onWindowLeaveFullScreen() {
    super.onWindowLeaveFullScreen();
    widget.onLeaveFullScreen?.call();
  }

  @override
  void onWindowEvent(String eventName) {
    super.onWindowEvent(eventName);
    widget.onEvent?.call(eventName);
  }
}
