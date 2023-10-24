import 'package:custom_window/src/f_icon_button.dart';
import 'package:custom_window/src/title_bar_button.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class TitleBar extends StatefulWidget {
  final Color? titleBarColor;
  final VoidCallback? onPop;
  final VoidCallback? onClose;
  final VoidCallback? onMinimize;
  final VoidCallback? onMaximize;
  final VoidCallback? onMoveStarted;
  final VoidCallback? onDoubleTap;
  final GlobalKey<NavigatorState>? navState;

  const TitleBar({
    super.key,
    this.titleBarColor,
    this.onPop,
    this.onClose,
    this.onMinimize,
    this.onMaximize,
    this.onMoveStarted,
    this.onDoubleTap,
    this.navState,
  });

  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> with WindowListener {
  bool isMaximized = false;
  bool isFocused = true;
  bool canPop = false;
  String title = "";

  void pop() {
    widget.navState?.currentState?.pop();
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    setState(() {
      windowManager.getTitle().then((value) => setState(() => title = value));
    });
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TitleBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        canPop = widget.navState?.currentState?.canPop() ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      color: widget.titleBarColor ?? Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanStart: (details) => widget.onMoveStarted?.call(),
              onDoubleTap: widget.onDoubleTap,
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
                    onPressed: canPop
                        ? () {
                            pop();
                            widget.onPop?.call();
                          }
                        : null,
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
                        onPressed: widget.onMinimize,
                        child: Image.asset(
                          "assets/images/minimize_icon.png",
                          isAntiAlias: true,
                          filterQuality: FilterQuality.high,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      TitleBarButton(
                        onPressed: widget.onMaximize,
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
                        onPressed: widget.onClose,
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
    );
  }
}
