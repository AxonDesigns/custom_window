library custom_window;

import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:window_manager/window_manager.dart';

export 'src/window_scaffold.dart';
export 'src/f_icon_button.dart';
export 'src/title_bar_button.dart';
export 'src/window_page.dart';

class CustomWindow with WindowListener {
  final VoidCallback? onClose;
  final VoidCallback? onMaximize;
  final VoidCallback? onUnMaximize;
  final VoidCallback? onMinimize;
  final VoidCallback? onFocus;
  final VoidCallback? onUnFocus;
  final VoidCallback? onMove;
  final VoidCallback? onMoved;
  final VoidCallback? onResize;
  final VoidCallback? onResized;
  final VoidCallback? onDocked;
  final VoidCallback? onUnDocked;
  final VoidCallback? onEnterFullScreen;
  final VoidCallback? onLeaveFullScreen;
  final Function(String event)? onEvent;

  static final CustomWindow instance = CustomWindow._();

  CustomWindow._({
    this.onClose,
    this.onMaximize,
    this.onUnMaximize,
    this.onMinimize,
    this.onFocus,
    this.onUnFocus,
    this.onMove,
    this.onMoved,
    this.onResize,
    this.onResized,
    this.onDocked,
    this.onUnDocked,
    this.onEnterFullScreen,
    this.onLeaveFullScreen,
    this.onEvent,
  }) {
    windowManager.addListener(this);
  }

  Future<void> initWindow({
    required String title,
    Size startSize = const Size(800, 600),
    Size minSize = const Size(400, 300),
    Size? maxSize,
    Color? backgroundColor,
    bool center = true,
    bool skipTaskbar = false,
    bool showTitleBar = false,
    bool windowButtonVisibility = false,
    bool alwaysOnTop = false,
    bool fullScreen = false,
    bool acrylicBackground = true,
  }) async {
    await Window.initialize();
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = WindowOptions(
      size: startSize,
      minimumSize: minSize,
      maximumSize: maxSize,
      center: center,
      backgroundColor: backgroundColor ?? Colors.transparent,
      skipTaskbar: skipTaskbar,
      titleBarStyle: showTitleBar ? TitleBarStyle.normal : TitleBarStyle.hidden,
      windowButtonVisibility: windowButtonVisibility,
      title: title,
      alwaysOnTop: alwaysOnTop,
      fullScreen: fullScreen,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();

      Window.setEffect(
        effect: acrylicBackground ? WindowEffect.acrylic : WindowEffect.solid,
        color: Colors.transparent,
        dark: true,
      );

      await Window.hideWindowControls();
    });
  }

  @override
  void onWindowClose() {
    super.onWindowClose();
    windowManager.removeListener(this);
    onClose?.call();
  }

  @override
  void onWindowBlur() {
    super.onWindowBlur();
    onUnFocus?.call();
  }

  @override
  void onWindowMinimize() {
    super.onWindowMinimize();
    onMinimize?.call();
  }

  @override
  void onWindowMove() {
    super.onWindowMove();
    onMove?.call();
  }

  @override
  void onWindowMoved() {
    super.onWindowMoved();
    onMoved?.call();
  }

  @override
  void onWindowMaximize() {
    super.onWindowMaximize();
    onMaximize?.call();
  }

  @override
  void onWindowFocus() {
    super.onWindowFocus();
    onFocus?.call();
  }

  @override
  void onWindowUnmaximize() {
    super.onWindowUnmaximize();
    onUnMaximize?.call();
  }

  @override
  void onWindowResize() {
    super.onWindowResize();
    onResize?.call();
  }

  @override
  void onWindowResized() {
    super.onWindowResized();
    onResized?.call();
  }

  @override
  void onWindowRestore() {
    super.onWindowRestore();
  }

  @override
  void onWindowDocked() {
    super.onWindowDocked();
    onDocked?.call();
  }

  @override
  void onWindowUndocked() {
    super.onWindowUndocked();
    onUnDocked?.call();
  }

  @override
  void onWindowEnterFullScreen() {
    super.onWindowEnterFullScreen();
    onEnterFullScreen?.call();
  }

  @override
  void onWindowLeaveFullScreen() {
    super.onWindowLeaveFullScreen();
    onLeaveFullScreen?.call();
  }

  @override
  void onWindowEvent(String eventName) {
    super.onWindowEvent(eventName);
    onEvent?.call(eventName);
  }
}

final customWindow = CustomWindow.instance;
