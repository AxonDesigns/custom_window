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

  CustomWindow._();

  /// Initializes window.
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

  /// Closes the window.
  Future<void> close() async => await windowManager.close();

  /// Initiates window dragging.
  Future<void> startDragging() async => await windowManager.startDragging();

  /// Maximizes the window, optionally only vertically.
  Future<void> maximize({bool vertically = false}) async => await windowManager.maximize(vertically: vertically);

  /// Restores the window from a maximized state.
  Future<void> unmaximize() async => await windowManager.unmaximize();

  /// Toggles between maximizing and restoring the window, optionally only vertically.
  Future<void> toggleMaximize({bool vertically = false}) async =>
      await windowManager.isMaximized() ? await windowManager.unmaximize() : await windowManager.maximize(vertically: vertically);

  /// Minimizes the window.
  Future<void> minimize() async => await windowManager.minimize();

  /// Restores the window if it is minimized or maximized.
  Future<void> restore() async => await windowManager.restore();

  /// Focuses on the window.
  Future<void> focus() async => await windowManager.focus();

  /// Removes focus from the window.
  Future<void> unFocus() async => await windowManager.blur();

  /// Hides the window.
  Future<void> hide() async => await windowManager.hide();

  /// Centers the window on the screen, optionally with animation.
  Future<void> center({bool animate = true}) async => await windowManager.center(animate: animate);

  /// Destroys the window.
  Future<void> get destroy async => await windowManager.destroy();

  /// Checks if the window is always on the bottom.
  Future<bool> get isAlwaysOnBottom async => await windowManager.isAlwaysOnBottom();

  /// Checks if the window is always on top.
  Future<bool> get isAlwaysOnTop async => await windowManager.isAlwaysOnTop();

  /// Checks if the window is closable.
  Future<bool> get isClosable async => await windowManager.isClosable();

  /// Checks if the window is dockable.
  Future<bool> get isDockable async => await windowManager.isDockable();

  /// Checks if the window is in full-screen mode.
  Future<bool> get isFullScreen async => await windowManager.isFullScreen();

  /// Checks if the window is maximized.
  Future<bool> get isMaximized async => await windowManager.isMaximized();

  /// Checks if the window is currently focused.
  Future<bool> get isFocused async => await windowManager.isFocused();

  /// Checks if the window is maximizable.
  Future<bool> get isMaximizable async => await windowManager.isMaximizable();

  /// Checks if the window is minimized.
  Future<bool> get isMinimized async => await windowManager.isMinimized();

  /// Checks if the window is minimizable.
  Future<bool> get isMinimizable async => await windowManager.isMinimizable();

  /// Checks if the window is movable.
  Future<bool> get isMovable async => await windowManager.isMovable();

  /// Checks if the window prevents closing.
  Future<bool> get isPreventClose async => await windowManager.isPreventClose();

  /// Checks if the window is resizable.
  Future<bool> get isResizable async => await windowManager.isResizable();

  /// Checks if the window is set to skip the taskbar.
  Future<bool> get isSkipTaskbar async => await windowManager.isSkipTaskbar();

  /// Checks if the window is visible on all workspaces.
  Future<bool> get isVisibleOnAllWorkspaces async => await windowManager.isVisibleOnAllWorkspaces();

  /// Checks if the window is currently visible.
  Future<bool> get isVisible async => await windowManager.isVisible();

  /// Docks the window to a side with a specified width.
  Future<void> dock({required DockingSide side, required int width}) async => await windowManager.dock(
        side: {DockingSide.left: DockSide.left, DockingSide.right: DockSide.right}[side]!,
        width: width,
      );

  /// Sets the title of the window.
  Future<void> setTitle(String title) async => await windowManager.setTitle(title);

  /// Sets a badge label for the window.
  Future<void> setBadgeLabel(String label) async => await windowManager.setBadgeLabel(label);

  /// Sets the window's visibility on all workspaces.
  Future<void> setVisibleOnAllWorkspaces(bool visible, {required bool visibleOnFullScreen}) async =>
      await windowManager.setVisibleOnAllWorkspaces(visible, visibleOnFullScreen: visibleOnFullScreen);

  /// Sets the visibility of the title bar and window buttons.
  Future<void> setTitleBarVisibility(bool visible, {required bool showWindowButtons}) async =>
      await windowManager.setTitleBarStyle(visible ? TitleBarStyle.normal : TitleBarStyle.hidden, windowButtonVisibility: showWindowButtons);

  /// Sets the alignment of the window on the screen.
  Future<void> setAlignment(Alignment alignment, {bool animate = true}) async => await windowManager.setAlignment(alignment, animate: animate);

  /// Sets whether the window should always be on the bottom.
  Future<void> setAlwaysOnBottom({bool alwaysOnBottom = false}) async => await windowManager.setAlwaysOnBottom(alwaysOnBottom);

  /// Sets whether the window should always be on top.
  Future<void> setAlwaysOnTop({bool alwaysOnTop = false}) async => await windowManager.setAlwaysOnTop(alwaysOnTop);

  /// Sets the window to be frameless (no window decorations).
  Future<void> setAsFrameless() async => await windowManager.setAsFrameless();

  /// Sets the aspect ratio of the window.
  Future<void> setAspectRatio(double ratio) async => await windowManager.setAspectRatio(ratio);

  /// Sets the background color of the window.
  Future<void> setBackgroundColor(Color color) async => await windowManager.setBackgroundColor(color);

  /// Sets the brightness of the window.
  Future<void> setBrightness(Brightness brightness) async => await windowManager.setBrightness(brightness);

  /// Sets the position and size of the window.
  Future<void> setBounds(Rect bounds) async => await windowManager.setBounds(bounds);

  /// Sets whether the window is closable.
  Future<void> setClosable(bool closable) async => await windowManager.setClosable(closable);

  /// Sets whether the window is in full-screen mode.
  Future<void> setFullScreen(bool fullScreen) async => await windowManager.setFullScreen(fullScreen);

  /// Sets whether the window has a shadow.
  Future<void> setHasShadow(bool hasShadow) async => await windowManager.setHasShadow(hasShadow);

  /// Sets the window icon from a file path.
  Future<void> setIcon(String path) async => await windowManager.setIcon(path);

  /// Sets whether the window should ignore mouse events.
  Future<void> setIgnoreMouseEvents(bool ignore) async => await windowManager.setIgnoreMouseEvents(ignore);

  /// Sets whether the window is maximizable.
  Future<void> setMaximizable(bool maximizable) async => await windowManager.setMaximizable(maximizable);

  /// Sets the maximum size the window can be resized to.
  Future<void> setMaximumSize(Size size) async => await windowManager.setMaximumSize(size);

  /// Sets whether the window is minimizable.
  Future<void> setMinimizable(bool minimizable) async => await windowManager.setMinimizable(minimizable);

  /// Sets the minimum size the window can be resized to.
  Future<void> setMinimumSize(Size size) async => await windowManager.setMinimumSize(size);

  /// Sets whether the window is movable.
  Future<void> setMovable(bool movable) async => await windowManager.setMovable(movable);

  /// Sets the opacity of the window.
  Future<void> setOpacity(double opacity) async => await windowManager.setOpacity(opacity);

  /// Sets whether the window should prevent being closed.
  Future<void> setPreventClose(bool preventClose) async => await windowManager.setPreventClose(preventClose);

  /// Sets the progress bar percentage in the taskbar.
  Future<void> setProgressBar(double percentage) async => await windowManager.setProgressBar(percentage);

  /// Sets whether the window is resizable.
  Future<void> setResizable(bool resizable) async => await windowManager.setResizable(resizable);

  /// Sets the size of the window.
  Future<void> setSize(Size size) async => await windowManager.setSize(size);

  /// Sets whether the window should be skipped in the taskbar.
  Future<void> setSkipTaskbar(bool skipTaskbar) async => await windowManager.setSkipTaskbar(skipTaskbar);

  /// Grabs the keyboard input for the window.
  Future<void> grabKeyboard() async => await windowManager.grabKeyboard();

  /// Displays the window's context menu.
  Future<void> popUpWindowMenu() async => await windowManager.popUpWindowMenu();

  /// Releases the grabbed keyboard input.
  Future<void> ungrabKeyboard() async => await windowManager.ungrabKeyboard();

  /// Shows the window if it's hidden.
  Future<void> show() async => await windowManager.show();

  /// Checks if the window has a shadow.
  Future<bool> get hasShadow async => await windowManager.hasShadow();

  /// Retrieves the current position and size of the window.
  Future<Rect> get bounds async => await windowManager.getBounds();

  /// Retrieves the title of the window.
  Future<String> get title async => await windowManager.getTitle();

  /// Retrieves the current position of the window.
  Future<Offset> get position async => await windowManager.getPosition();

  /// Retrieves the current size of the window.
  Future<Size> get size async => await windowManager.getSize();

  /// Retrieves the current opacity of the window.
  Future<double> get opacity async => await windowManager.getOpacity();

  /// Retrieves the device pixel ratio of the window.
  double get devicePixelRatio => windowManager.getDevicePixelRatio();
}

enum DockingSide { left, right }

/// Singleton instance of [CustomWindow].
final customWindow = CustomWindow.instance;
