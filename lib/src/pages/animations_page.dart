import 'package:flutter/material.dart';
import 'dart:math' as Math;

class AnimationsPage extends StatelessWidget {
  const AnimationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _AnimatedSquare(),
      ),
    );
  }
}

class _AnimatedSquare extends StatefulWidget {
  const _AnimatedSquare({
    super.key,
  });

  @override
  State<_AnimatedSquare> createState() => _AnimatedSquareState();
}

class _AnimatedSquareState extends State<_AnimatedSquare>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotation;
  late Animation<double> opacity;
  late Animation<double> opacityOut;
  late Animation<double> moveRight;
  late Animation<double> enlarge;
  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000));
    rotation = Tween(begin: 0.0, end: 2.0 * Math.pi)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    opacity = Tween(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0, 0.25, curve: Curves.easeOut))
    );
    opacityOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.75, 1, curve: Curves.easeOut))
    );
    moveRight = Tween(begin: 0.0, end: 200.0).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    enlarge =Tween(begin: 1.0, end: 2.0).animate(controller); 
    controller.addListener(() {
      // debugPrint('Status: ${controller.status}');
      if (controller.status == AnimationStatus.completed) {
        controller.reverse();
      }
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
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      child: _Square(),
      builder: (BuildContext context, Widget? child) {
        // debugPrint('Rotation${rotation.value}');
        return Transform.translate(
          offset: Offset(moveRight.value, 0),
          child: Transform.rotate(
              angle: rotation.value,
              child: Opacity(
                opacity: opacity.value - opacityOut.value,
                child: Transform.scale(
                  scale: enlarge.value,
                  child: child) ,
              )),
        );
      },
    );
  }
}

class _Square extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(color: Colors.blue),
    );
  }
}
