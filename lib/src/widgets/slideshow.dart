import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool dotsUp;
  final Color primaryColor;
  final Color secondaryColor;
  final int primaryBullet;
  final int secondaryBullet;
  const Slideshow(
      {super.key,
      required this.slides,
      this.dotsUp = false,
      this.primaryColor = Colors.blue,
      this.secondaryColor = Colors.grey,
      this.primaryBullet = 12,
      this.secondaryBullet = 12});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return _SliderModel();
      },
      child: SafeArea(
        child: Center(child: Builder(
          builder: (context) {
            Provider.of<_SliderModel>(context).primaryColor = primaryColor;
            Provider.of<_SliderModel>(context).secondaryColor = secondaryColor;
            Provider.of<_SliderModel>(context).primaryBullet = primaryBullet;
            Provider.of<_SliderModel>(context).secondaryBullet =
                secondaryBullet;
            return Column(
              children: [
                if (dotsUp)
                  _Dots(
                    length: slides.length,
                  ),
                Expanded(
                  child: _Slides(
                    slides: slides,
                  ),
                ),
                if (!dotsUp)
                  _Dots(
                    length: slides.length,
                  ),
              ],
            );
          },
        )),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int length;
  const _Dots({super.key, required this.length});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(length, (index) => _Dot(index: index)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  const _Dot({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {  
    final sliderModel = Provider.of<_SliderModel>(context);
    int size;
    Color color;
    if (sliderModel.currentPage >= index - 0.5 &&
        sliderModel.currentPage < index + 0.5) {
          size = sliderModel.primaryBullet;
          color= sliderModel.primaryColor;
    } else {
      size = sliderModel.secondaryBullet;
          color= sliderModel.secondaryColor;
    }
    return AnimatedContainer(
      width: size.toDouble(),
      height: size.toDouble(),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle),
      duration: const Duration(milliseconds: 5),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;
  const _Slides({super.key, required this.slides});

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();
  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      Provider.of<_SliderModel>(context, listen: false).currentPage =
          pageViewController.page!;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageViewController,
      // children: const [
      //   _Slide(svg:'assets/svgs/slide-1.svg'),
      //   _Slide(svg: 'assets/svgs/slide-2.svg'),
      //   _Slide(svg: 'assets/svgs/slide-3.svg'),
      // ],
      children: widget.slides
          .map((slide) => _Slide(
                slide: slide,
              ))
          .toList(),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;
  const _Slide({
    super.key,
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(30),
        child: slide);
  }
}

class _SliderModel with ChangeNotifier {
  double _currentPage = 0;
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.blue;
  int _primaryBullet = 12;
  int _secondaryBullet = 12;
  int get primaryBullet => _primaryBullet;

  set primaryBullet(int value) => _primaryBullet = value;

  get secondaryBullet => _secondaryBullet;

  set secondaryBullet(value) => _secondaryBullet = value;
  get primaryColor => _primaryColor;

  set primaryColor(value) => _primaryColor = value;

  get secondaryColor => _secondaryColor;

  set secondaryColor(value) => _secondaryColor = value;
  double get currentPage => _currentPage;

  set currentPage(double value) {
    _currentPage = value;
    notifyListeners();
  }
}
