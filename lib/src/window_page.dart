import 'package:custom_window/src/math_utility.dart';
import 'package:flutter/material.dart';

class WindowPage<T> extends Page<T> {
  final Widget child;

  final bool maintainState;

  final bool fullscreenDialog;

  final bool allowSnapshotting;

  final Duration duration;

  final Curve curve;

  const WindowPage({
    required this.child,
    this.fullscreenDialog = true,
    this.allowSnapshotting = true,
    this.maintainState = false,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.easeInOutExpo,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return _WindowPageRoute(this);
  }
}

class _WindowPageRoute<T> extends PageRoute<T> {
  _WindowPageRoute(WindowPage<T> page) : super(settings: page);

  WindowPage<T> get _page => settings as WindowPage<T>;

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: _page.child,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    final mainReverse = animation.status == AnimationStatus.reverse;
    final secondReverse = secondaryAnimation.status == AnimationStatus.reverse;

    final mainAnimOffset = Tween<Offset>(
      begin: Offset(0.0, mainReverse ? -0.1 : 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: _page.curve));

    final secondAnimOffset = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.0, secondReverse ? 0.1 : -0.1),
    ).animate(CurvedAnimation(parent: secondaryAnimation, curve: _page.curve));

    return Stack(
      children: [
        SlideTransition(
          position: mainAnimOffset,
          child: Opacity(
            opacity: inverseLerp(0.45, 1, animation.value).clamp(0, 1),
            child: SlideTransition(
              position: secondAnimOffset,
              child: Opacity(
                opacity: inverseLerp(0.45, 1, 1 - secondaryAnimation.value).clamp(0, 1),
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get maintainState => _page.maintainState;

  @override
  Duration get transitionDuration => _page.duration;
}
