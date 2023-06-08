import 'package:custom_painter/src/challenges/animated_square_page.dart.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {    
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Designs',
      home: AnimatedSquarePage(),
    );
  }
}