import 'package:custom_window/custom_window.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class TitleBar extends StatefulWidget {
  final Color? titleBarColor;
  final double height;
  final GlobalKey<NavigatorState>? navState;

  const TitleBar({
    super.key,
    this.titleBarColor,
    this.height = 46,
    this.navState,
  });

  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
  bool _isMaximized = false;
  bool _isFocused = true;
  bool _canPop = false;
  String _title = "";

  void pop() {
    widget.navState?.currentState?.pop();
  }

  @override
  void initState() {
    super.initState();
    customWindow.title.then((value) => setState(() => _title = value));
    customWindow.isMaximized.then((value) => setState(() => _isMaximized = value));
    customWindow.isFocused.then((value) => setState(() => _isFocused = value));
  }

  @override
  void didUpdateWidget(covariant TitleBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => _canPop = widget.navState?.currentState?.canPop() ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WindowCallbackContainer(
      onFocus: () => setState(() => _isFocused = true),
      onUnFocus: () => setState(() => _isFocused = false),
      onMaximize: () => setState(() => _isMaximized = true),
      onUnMaximize: () => setState(() => _isMaximized = false),
      onMinimize: () => setState(() => _isFocused = false),
      onRestore: () => setState(() => _isFocused = true),
      child: Container(
        height: widget.height,
        color: widget.titleBarColor ?? Colors.transparent,
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onPanStart: (details) => customWindow.startDragging(),
                onDoubleTap: () => customWindow.toggleMaximize(),
              ),
            ),
            Positioned.fill(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 75),
                curve: Curves.easeInOut,
                opacity: _isFocused ? 1 : 0.5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 6),
                    TitleBarBackButton(
                      onPressed: _canPop ? () => pop() : null,
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
                        _title,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TitleBarButton(
                          onPressed: () => customWindow.minimize(),
                          maxSize: const Size(double.infinity, 30),
                          child: Image.asset(
                            "assets/images/minimize_icon.png",
                            package: "custom_window",
                            isAntiAlias: true,
                            filterQuality: FilterQuality.high,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        TitleBarButton(
                          onPressed: () => customWindow.toggleMaximize(),
                          maxSize: const Size(double.infinity, 30),
                          child: Image.asset(
                            "assets/images/${_isMaximized ? "unmaximize_icon" : "maximize_icon"}.png",
                            package: "custom_window",
                            isAntiAlias: true,
                            filterQuality: FilterQuality.high,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        TitleBarButton(
                          hoveredColor: Colors.red,
                          activeColor: Colors.red.shade900,
                          maxSize: const Size(double.infinity, 30),
                          onPressed: () => customWindow.close(),
                          childBuilder: (pressed, hovered, enabled) => Image.asset(
                            "assets/images/close_icon.png",
                            package: "custom_window",
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
    );
  }
}
