library custom_window;

import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:window_manager/window_manager.dart';

export 'src/window_scaffold.dart';
export 'src/f_icon_button.dart';
export 'src/title_bar_button.dart';
export 'src/window_page.dart';

Future<void> initWindow({
  required String title,
  Size startSize = const Size(800, 600),
  Size minSize = const Size(400, 300),
  Size maxSize = const Size(400, 300),
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
