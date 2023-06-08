import 'package:flutter/material.dart';

class AnimatedSquarePage extends StatelessWidget {
  const AnimatedSquarePage({super.key});

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
  late Animation<double> moveRight;
  late Animation<double> moveUp;
  late Animation<double> moveLeft;
  late Animation<double> moveDown;
  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4500));
    moveRight = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.25, curve: Curves.bounceOut)));
    moveUp = Tween(begin: 0.0, end: -100.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.25, 0.50, curve: Curves.bounceOut)));
    moveLeft = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.50, 0.75, curve: Curves.bounceOut)));
    moveDown = Tween(begin: 0.0, end: -100.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.75, 1.0, curve: Curves.bounceOut)));
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // late double dx;
    // late double dy;
    // if (moveRight.value <= 0.80) {
    //   dx = moveRight.value;
    //   dy = 0;
    // }
    // dx = moveRight.value;
    //   dy = 0;
    controller.repeat();
    return AnimatedBuilder(
      animation: controller,
      child: _Square(),
      builder: (context, child) {
        return Transform.translate(
            offset: Offset(moveRight.value - moveLeft.value, moveUp.value - moveDown.value), child: child);
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
