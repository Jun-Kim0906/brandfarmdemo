import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimateIcons extends StatefulWidget {
  const AnimateIcons({
    /// The IconData that will be visible before animation Starts
    @required this.startIcon,

    /// The IconData that will be visible after animation ends
    @required this.endIcon,

    /// The callback on startIcon Press
    /// It should return a bool
    /// If true is returned it'll animate to the end icon
    /// if false is returned it'll not animate to the end icons
    this.onStartIconPress,

    /// The callback on endIcon Press
    /// /// It should return a bool
    /// If true is returned it'll animate to the end icon
    /// if false is returned it'll not animate to the end icons
    this.onEndIconPress,

    /// The size of the icon that are to be shown.
    this.size,

    /// AnimateIcons controller
    this.controller,

    /// The color of the icons that are to be shown
    this.color,

    /// The duration for which the animation runs
    this.duration,

    /// If the animation runs in the clockwise or anticlockwise direction
    this.clockwise,

    /// This is the tooltip that will be used for the [startIcon]
    this.startTooltip,

    /// This is the tooltip that will be used for the [endIcon]
    this.endTooltip,
  });
  final Widget startIcon, endIcon;
  final bool Function() onStartIconPress, onEndIconPress;
  final Duration duration;
  final bool clockwise;
  final double size;
  final Color color;
  final AnimateIconController controller;
  final String startTooltip, endTooltip;

  @override
  _AnimateIconsState createState() => _AnimateIconsState();
}

class _AnimateIconsState extends State<AnimateIcons>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    this._controller = new AnimationController(
      vsync: this,
      duration: widget.duration ?? Duration(seconds: 1),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    this._controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    initControllerFunctions();
    super.initState();
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  initControllerFunctions() {
    if (widget.controller != null) {
      widget.controller.animateToEnd = () {
        _controller.forward();
        return true;
      };
      widget.controller.animateToStart = () {
        _controller.reverse();
        return true;
      };
      widget.controller.isStart = () => _controller.value == 0.0;
      widget.controller.isEnd = () => _controller.value == 1.0;
    }
  }

  _onStartIconPress() {
    if (widget.onStartIconPress()) _controller.forward();
  }

  _onEndIconPress() {
    if (widget.onEndIconPress()) _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    double x = _controller.value ?? 0.0;
    double y = 1.0 - _controller.value ?? 0.0;
    double angleX = math.pi / 180 * (180 * x);
    double angleY = math.pi / 180 * (180 * y);

    Widget first() {
      final icon = widget.startIcon;
      return Transform.rotate(
        angle: widget.clockwise ?? false ? angleX : -angleX,
        child: Opacity(
          opacity: y,
          child: IconButton(
            iconSize: widget.size,
            color: widget.color ?? Theme.of(context).primaryColor,
            disabledColor: widget.color,
            icon: widget.startTooltip == null
                ? icon
                : Tooltip(
              message: widget.startTooltip,
              child: icon,
            ),
            onPressed:
            widget.onStartIconPress != null ? _onStartIconPress : null,
          ),
        ),
      );
    }

    Widget second() {
      final icon = widget.endIcon;
      return Transform.rotate(
        angle: widget.clockwise ?? false ? -angleY : angleY,
        child: Opacity(
          opacity: x ?? 0.0,
          child: IconButton(
            iconSize: widget.size,
            color: widget.color ?? Theme.of(context).primaryColor,
            disabledColor: widget.color,
            icon: widget.endTooltip == null
                ? icon
                : Tooltip(
              message: widget.endTooltip,
              child: icon,
            ),
            onPressed: widget.onEndIconPress != null ? _onEndIconPress : null,
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        x == 1 && y == 0 ? second() : first(),
        x == 0 && y == 1 ? first() : second(),
      ],
    );
  }
}

class AnimateIconController {
  bool Function() animateToStart, animateToEnd;
  bool Function() isStart, isEnd;
}