import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final double percentege;
  final Color primaryColor;
  const RadialProgress({super.key, required this.percentege, this.primaryColor = Colors.blue});

  @override
  State<RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  double previousPercentage = 0.0;
  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);
    final differenceAnimate = widget.percentege - previousPercentage;
    previousPercentage = widget.percentege;
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CustomPaint(
              painter: _MyRadialProgress(percentage: (widget.percentege - differenceAnimate) + (differenceAnimate * controller.value), primaryColor: widget.primaryColor),
            ));
      },
    );
  }
}

class _MyRadialProgress extends CustomPainter {
  final double percentage;
  final Color primaryColor;
  _MyRadialProgress({required this.percentage, required this.primaryColor});
  @override
  void paint(Canvas canvas, Size size) {
    //Circle
    final Rect rect =
        Rect.fromCircle(center: const Offset(0.0, 50.0), radius: 180);
    const Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
        colors: [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 0, 255, 4), Color.fromARGB(255, 1, 34, 251)]);
        
    final paintCircle = Paint()
      ..strokeWidth = 2
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width * 0.5, size.width * 0.5);
    double radius = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radius, paintCircle);
    //arc
    final paintArc = Paint()
      ..strokeWidth = 5
      // ..color = primaryColor
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    double arcAngle = 2 * pi * (percentage / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paintArc);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
