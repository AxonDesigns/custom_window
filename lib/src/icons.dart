import 'package:flutter/material.dart';

class CloseIcon extends StatelessWidget {
  const CloseIcon({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/close_icon.png",
      package: "custom_window",
      isAntiAlias: true,
      filterQuality: FilterQuality.high,
      color: color ?? Theme.of(context).colorScheme.onBackground,
    );
  }
}

class MinimizeIcon extends StatelessWidget {
  const MinimizeIcon({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/minimize_icon.png",
      package: "custom_window",
      isAntiAlias: true,
      filterQuality: FilterQuality.high,
      color: color ?? Theme.of(context).colorScheme.onBackground,
    );
  }
}

class MaximizeIcon extends StatelessWidget {
  const MaximizeIcon({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/maximize_icon.png",
      package: "custom_window",
      isAntiAlias: true,
      filterQuality: FilterQuality.high,
      color: color ?? Theme.of(context).colorScheme.onBackground,
    );
  }
}

class UnmaximazeIcon extends StatelessWidget {
  const UnmaximazeIcon({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/unmaximize_icon.png",
      package: "custom_window",
      isAntiAlias: true,
      filterQuality: FilterQuality.high,
      color: color ?? Theme.of(context).colorScheme.onBackground,
    );
  }
}
