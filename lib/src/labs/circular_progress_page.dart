import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgressPage extends StatefulWidget {
  const CircularProgressPage({super.key});

  @override
  State<CircularProgressPage> createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  double percentage = 0.0;
  double newPercentage = 0.0;
  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    controller.addListener(() {
      // print('controller value: ${controller.value}');
      setState(() {
        percentage = lerpDouble(percentage, newPercentage, controller.value)!;
        print(percentage);
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          percentage = newPercentage;
          newPercentage += 10;
          if (newPercentage > 100) {
            newPercentage = 0;
            percentage = 0;
          }
          controller.forward(from: 0.0);
          setState(() {});
        },
        backgroundColor: Colors.pink,
        child: const Icon(Icons.refresh),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(5),
          width: 300,
          height: 300,
          child: CustomPaint(
            painter: _MyRadialProgress(percentage),
          ),
        ),
      ),
    );
  }
}

class _MyRadialProgress extends CustomPainter {
  final percentage;

  _MyRadialProgress(this.percentage);
  @override
  void paint(Canvas canvas, Size size) {
    //Circle
    final paintCircle = Paint()
      ..strokeWidth = 5
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width * 0.5, size.width * 0.5);
    double radius = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radius, paintCircle);
    //arc
    final paintArc = Paint()
      ..strokeWidth = 5
      ..color = Colors.pink
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
