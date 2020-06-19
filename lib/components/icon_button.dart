import 'package:flutter/material.dart';

class RectIconButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Widget child;
  final VoidCallback onPressed;
  const RectIconButton({
    Key key,
    @required this.onPressed,
    this.width,
    this.height,
    this.color,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(0),
      minWidth: width,
      height: height,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onPressed: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: color,
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(80),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class CircularIconButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Widget child;
  final VoidCallback onPressed;
  const CircularIconButton({
    Key key,
    @required this.onPressed,
    this.width,
    this.height,
    @required this.color,
    this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(0),
      minWidth: width,
      height: height,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.elliptical(16.0, 16.0)),
      ),
      onPressed: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(16.0, 16.0)),
          color: color,
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(80),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
