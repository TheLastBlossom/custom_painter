import 'package:custom_painter/src/widgets/slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // backgroundColor: Colors.amber,
        body: Column(
      children: [
        Expanded(child: MySlideshow()),
        Expanded(child: MySlideshow()),
      ],
    ));
  }
}

class MySlideshow extends StatelessWidget {
  const MySlideshow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Slideshow(
      slides: [
        SvgPicture.asset('assets/svgs/slide-1.svg'),
        SvgPicture.asset('assets/svgs/slide-2.svg'),
        SvgPicture.asset('assets/svgs/slide-3.svg'),
        SvgPicture.asset('assets/svgs/slide-4.svg'),
        SvgPicture.asset('assets/svgs/slide-5.svg'),
      ],
      dotsUp: false,
      primaryColor: Colors.purple,
      primaryBullet: 25,
      secondaryBullet: 15,
    );
  }
}
