import 'package:flutter/material.dart';

/// Creates a line in the direction given.
/// The line will have the other properties given:
/// color, length and thickness
class Line extends StatelessWidget {

  /// Creates a line in the direction given.
  /// The line will have the other properties given:
  /// color, length and thickness
  const Line({
    Key key,
    @required this.length,
    this.thickness = 1.0,
    this.color = Colors.white,
    this.direction = LineDirection.Horizontal,
  }) : super(key: key);

  final double length;
  final double thickness;
  final Color color;
  final LineDirection direction;

  bool isHorizontal() => direction == LineDirection.Horizontal;

  bool isVertical() => direction == LineDirection.Vertical;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: isHorizontal() ? length : thickness,
      height: isVertical() ? length : thickness,
    );
  }
}

enum LineDirection { Horizontal, Vertical }
