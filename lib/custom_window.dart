library custom_window;

import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:async';

export 'src/window_scaffold.dart';
export 'src/f_icon_button.dart';
export 'src/title_bar_button.dart';
export 'src/window_page.dart';

class CustomWindow with WindowListener {
  static final CustomWindow instance = CustomWindow._();

  bool isMaximized = false;
  bool isFocused = true;

  CustomWindow._() {
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

  Future<void> close() async => await windowManager.close();

  Future<void> startDragging() async => await windowManager.startDragging();

  Future<void> maximize({bool vertically = false}) async => await windowManager.maximize(vertically: vertically);

  Future<void> unmaximize() async => await windowManager.unmaximize();

  Future<void> toggleMaximize({bool vertically = false}) async =>
      await windowManager.isMaximized() ? await windowManager.unmaximize() : await windowManager.maximize(vertically: vertically);

  Future<void> minimize() async => await windowManager.minimize();

  Future<void> restore() async => await windowManager.restore();

  Future<void> focus() async => await windowManager.focus();

  Future<void> unFocus() async => await windowManager.blur();

  Future<void> setTitle(String title) async => await windowManager.setTitle(title);

  /*@override
  void onWindowClose() {
    super.onWindowClose();
    windowManager.removeListener(this);
    onClose?.call();
  }

  @override
  void onWindowBlur() {
    super.onWindowBlur();
    isFocused = false;
    onUnFocus?.call();
  }

  @override
  void onWindowMinimize() {
    super.onWindowMinimize();
    isFocused = false;
    onMinimize?.call();
  }

  @override
  void onWindowMove() {
    super.onWindowMove();
    isFocused = true;
    isMaximized = false;
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
    isMaximized = true;
    onMaximize?.call();
  }

  @override
  void onWindowFocus() {
    super.onWindowFocus();
    isFocused = true;
    onFocus?.call();
  }

  @override
  void onWindowUnmaximize() {
    super.onWindowUnmaximize();
    isMaximized = false;
    onUnMaximize?.call();
  }

  @override
  void onWindowResize() {
    super.onWindowResize();
    isMaximized = false;
    onResize?.call();
  }

  @override
  void onWindowResized() {
    super.onWindowResized();
    onResized?.call();
  }

  @override
  void onWindowRestore() {
    isFocused = true;
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
  }*/
}

final customWindow = CustomWindow.instance;
