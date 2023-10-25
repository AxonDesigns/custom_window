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
    bool focusAtStartup = true,
    bool hideAtStartup = false,
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
      hideAtStartup ? await windowManager.hide() : await windowManager.show();
      focusAtStartup ? await windowManager.focus() : await windowManager.blur();
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

  Future<void> hide() async => await windowManager.hide();

  Future<void> center({bool animate = true}) async => await windowManager.center(animate: animate);

  Future<void> get destroy async => await windowManager.destroy();

  Future<bool> get isAlwaysOnBottom async => await windowManager.isAlwaysOnBottom();

  Future<bool> get isAlwaysOnTop async => await windowManager.isAlwaysOnTop();

  Future<bool> get isClosable async => await windowManager.isClosable();

  Future<bool> get isDockable async => await windowManager.isDockable();

  Future<bool> get isFullScreen async => await windowManager.isFullScreen();

  Future<bool> get isMaximizable async => await windowManager.isMaximizable();

  Future<bool> get isMinimized async => await windowManager.isMinimized();

  Future<bool> get isMinimizable async => await windowManager.isMinimizable();

  Future<bool> get isMovable async => await windowManager.isMovable();

  Future<bool> get isPreventClose async => await windowManager.isPreventClose();

  Future<bool> get isResizable async => await windowManager.isResizable();

  Future<bool> get isSkipTaskbar async => await windowManager.isSkipTaskbar();

  Future<bool> get isVisibleOnAllWorkspaces async => await windowManager.isVisibleOnAllWorkspaces();

  Future<bool> get isVisible async => await windowManager.isVisible();

  Future<void> dock({required DockingSide side, required int width}) async => await windowManager.dock(
        side: {DockingSide.left: DockSide.left, DockingSide.right: DockSide.right}[side]!,
        width: width,
      );

  Future<void> setTitle(String title) async => await windowManager.setTitle(title);

  Future<void> setBadgeLabel(String label) async => await windowManager.setBadgeLabel(label);

  Future<void> setVisibleOnAllWorkspaces(bool visible, {required bool visibleOnFullScreen}) async =>
      await windowManager.setVisibleOnAllWorkspaces(visible, visibleOnFullScreen: visibleOnFullScreen);

  Future<void> setTitleBarVisibility(bool visible, {required bool showWindowButtons}) async =>
      await windowManager.setTitleBarStyle(visible ? TitleBarStyle.normal : TitleBarStyle.hidden, windowButtonVisibility: showWindowButtons);

  Future<void> setAlignment(Alignment alignment, {bool animate = true}) async => await windowManager.setAlignment(alignment, animate: animate);

  Future<void> setAlwaysOnBottom({bool alwaysOnBottom = false}) async => await windowManager.setAlwaysOnBottom(alwaysOnBottom);

  Future<void> setAlwaysOnTop({bool alwaysOnTop = false}) async => await windowManager.setAlwaysOnTop(alwaysOnTop);

  Future<void> setAsFrameless() async => await windowManager.setAsFrameless();

  Future<void> setAspectRatio(double ratio) async => await windowManager.setAspectRatio(ratio);

  Future<void> setBackgroundColor(Color color) async => await windowManager.setBackgroundColor(color);

  Future<void> setBrightness(Brightness brightness) async => await windowManager.setBrightness(brightness);

  Future<void> setBounds(Rect bounds) async => await windowManager.setBounds(bounds);

  Future<void> setClosable(bool closable) async => await windowManager.setClosable(closable);

  Future<void> setFullScreen(bool fullScreen) async => await windowManager.setFullScreen(fullScreen);

  Future<void> setHasShadow(bool hasShadow) async => await windowManager.setHasShadow(hasShadow);

  Future<void> setIcon(String path) async => await windowManager.setIcon(path);

  Future<void> setIgnoreMouseEvents(bool ignore) async => await windowManager.setIgnoreMouseEvents(ignore);

  Future<void> setMaximizable(bool maximizable) async => await windowManager.setMaximizable(maximizable);

  Future<void> setMaximumSize(Size size) async => await windowManager.setMaximumSize(size);

  Future<void> setMinimizable(bool minimizable) async => await windowManager.setMinimizable(minimizable);

  Future<void> setMinimumSize(Size size) async => await windowManager.setMinimumSize(size);

  Future<void> setMovable(bool movable) async => await windowManager.setMovable(movable);

  Future<void> setOpacity(double opacity) async => await windowManager.setOpacity(opacity);

  Future<void> setPreventClose(bool preventClose) async => await windowManager.setPreventClose(preventClose);

  Future<void> setProgressBar(double percentage) async => await windowManager.setProgressBar(percentage);

  Future<void> setResizable(bool resizable) async => await windowManager.setResizable(resizable);

  Future<void> setSize(Size size) async => await windowManager.setSize(size);

  Future<void> setSkipTaskbar(bool skipTaskbar) async => await windowManager.setSkipTaskbar(skipTaskbar);

  Future<void> grabKeyboard() async => await windowManager.grabKeyboard();

  Future<void> popUpWindowMenu() async => await windowManager.popUpWindowMenu();

  Future<void> ungrabKeyboard() async => await windowManager.ungrabKeyboard();

  Future<void> show() async => await windowManager.show();

  Future<bool> get hasShadow async => await windowManager.hasShadow();

  Future<Rect> get bounds async => await windowManager.getBounds();

  Future<String> get title async => await windowManager.getTitle();

  Future<Offset> get position async => await windowManager.getPosition();

  Future<Size> get size async => await windowManager.getSize();

  Future<double> get opacity async => await windowManager.getOpacity();

  double get devicePixelRatio => windowManager.getDevicePixelRatio();
}

enum DockingSide { left, right }

final customWindow = CustomWindow.instance;
