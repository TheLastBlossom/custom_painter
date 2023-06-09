import 'package:custom_painter/src/widgets/radial_progress.dart';
import 'package:flutter/material.dart';
class CircleGraphsPage extends StatefulWidget {
  const CircleGraphsPage({super.key});

  @override
  State<CircleGraphsPage> createState() => _CircleGraphsPageState();
}

class _CircleGraphsPageState extends State<CircleGraphsPage> {
  double percentage = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:FloatingActionButton(onPressed: () {
        percentage +=10;
        if(percentage>100){
          percentage = 0;
        }
        setState(() {
          
        });
      },child: const Icon(Icons.refresh),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: [          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadialProgress(percentage: percentage, primaryColor: Colors.blue,),
              CustomRadialProgress(percentage: percentage, primaryColor: Colors.yellow,)
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadialProgress(percentage: percentage, primaryColor: Colors.black,),
              CustomRadialProgress(percentage: percentage, primaryColor: Colors.green,)
            ],
          )
        ],
      ),
    );
  }
}

class CustomRadialProgress extends StatelessWidget {
  final Color primaryColor;
  const CustomRadialProgress({
    super.key,
    required this.percentage, required this.primaryColor,
  });

  final double percentage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: RadialProgress(percentege: percentage, primaryColor: primaryColor,)
    );
  }
}