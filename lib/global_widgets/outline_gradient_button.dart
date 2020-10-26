import '../constants/constants.dart';
import 'package:flutter/material.dart';

class OutlineGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final _GradientPainter painter;
  final EdgeInsetsGeometry padding;

  OutlineGradientButton({
    @required text,
    @required onPressed,
    this.padding = const EdgeInsets.all(0),
  })  : painter = _GradientPainter(
          strokeWidth: 2.5,
          radius: 30.0,
          gradient: AppConstants.gradient,
        ),
        this.onPressed = onPressed,
        this.text = text;

  @override
  Widget build(BuildContext context) {
    final btnText = Text(
      text.toUpperCase(),
      style: TextStyle(
        fontWeight: FontWeight.w800,
        color: Theme.of(context).primaryColor,
      ),
    );

    return CustomPaint(
      painter: painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onPressed,
        child: InkWell(
          borderRadius: BorderRadius.circular(30.0),
          onTap: onPressed,
          child: Container(
            constraints: BoxConstraints(minWidth: 88, minHeight: 35),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: padding,
                  child: btnText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter(
      {@required double strokeWidth,
      @required double radius,
      @required Gradient gradient})
      : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
