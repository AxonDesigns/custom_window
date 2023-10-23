import 'package:custom_window/src/f_icon_button.dart';
import 'package:custom_window/src/title_bar_button.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class WindowScaffold extends StatefulWidget {
  final Widget Function(bool maximized, bool focused) body;
  final Color? titleBarColor;
  final Color? BackgroundColor;
  final GlobalKey<NavigatorState> navState;
  const WindowScaffold({
    super.key,
    required this.body,
    this.titleBarColor,
    this.BackgroundColor,
    required this.navState,
  });

  @override
  State<StatefulWidget> createState() => _WindowScaffoldState();
}

class _WindowScaffoldState extends State<WindowScaffold> with WindowListener {
  bool isMaximized = false;
  bool isFocused = true;
  bool canPop = false;
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        canPop = widget.navState.currentState?.canPop() ?? false;
      });
    });
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void pop() {
    widget.navState.currentState?.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Material(
        color: widget.BackgroundColor ?? Theme.of(context).colorScheme.background.withOpacity(0.8),
        child: Column(
          children: [
            Container(
              height: 46,
              color: widget.titleBarColor ?? Colors.transparent,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onPanStart: (details) => windowManager.startDragging(),
                    ),
                  ),
                  Positioned.fill(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                      opacity: isFocused ? 1 : 0.5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 6),
                          FIconButton(
                            onPressed: canPop ? () => pop() : null,
                            minSize: const Size(40, 0),
                            childBuilder: (pressed, hovered, enabled) => ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              child: TweenAnimationBuilder(
                                tween: Tween<double>(begin: 0.0, end: pressed ? 3 : 0),
                                duration: Duration(milliseconds: pressed ? 25 : 700),
                                curve: pressed ? Curves.easeInOut : Curves.elasticOut,
                                builder: (context, value, child) => Transform.translate(offset: Offset(value, 0), child: child),
                                child: Opacity(opacity: pressed ? 0.7 : 1.0, child: const Icon(FluentIcons.arrow_left_12_regular, size: 14)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          IgnorePointer(
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TitleBarButton(
                                onPressed: () {
                                  windowManager.minimize();
                                },
                                child: Image.asset(
                                  "assets/images/minimize_icon.png",
                                  isAntiAlias: true,
                                  filterQuality: FilterQuality.high,
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                              ),
                              TitleBarButton(
                                onPressed: () {
                                  isMaximized ? windowManager.unmaximize() : windowManager.maximize();
                                },
                                child: Image.asset(
                                  "assets/images/${isMaximized ? "unmaximize_icon" : "maximize_icon"}.png",
                                  isAntiAlias: true,
                                  filterQuality: FilterQuality.high,
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                              ),
                              TitleBarButton(
                                hoveredColor: Colors.red,
                                activeColor: Colors.red.shade900,
                                onPressed: () {
                                  windowManager.close();
                                },
                                childBuilder: (pressed, hovered, enabled) => Image.asset(
                                  "assets/images/close_icon.png",
                                  isAntiAlias: true,
                                  filterQuality: FilterQuality.high,
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
