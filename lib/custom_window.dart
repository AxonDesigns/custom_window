library custom_window;

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:async';

export 'src/window_scaffold.dart';
export 'src/f_icon_button.dart';
export 'src/title_bar_button.dart';
export 'src/window_page.dart';
export 'src/title_bar.dart';
export 'src/window_callback_container.dart';

class CustomWindow {
  static final CustomWindow instance = CustomWindow._();

  bool isMaximized = false;
  bool isFocused = true;

  CustomWindow._();

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
  }) async {
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
  Future<String> getTitle() async => await windowManager.getTitle();
}

final customWindow = CustomWindow.instance;
