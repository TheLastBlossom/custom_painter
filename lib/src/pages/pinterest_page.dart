import 'package:custom_painter/src/widgets/pinterest_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class PinterestPage extends StatelessWidget {
  const PinterestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return _MenuModel();
      },
      child: const Scaffold(
        body: Stack(
          children: [PinterestGrid(), _PinterestMenu()],
        ),
      ),
    );
  }
}

class _PinterestMenu extends StatelessWidget {
  const _PinterestMenu({super.key});
  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final show = Provider.of<_MenuModel>(context).show;
    return Positioned(
        bottom: 30,
        child: SizedBox(
          width: widthScreen,
          child: Align(
              child: PinterestMenu(
            show: show,
            colorIconSelected: Colors.pink,
            colorIcon: Colors.black,
            items: [
              PinteresBottomModel(
                  onPressed: () {
                    print('Icon piechart');
                  },
                  icon: Icons.pie_chart),
              PinteresBottomModel(
                  onPressed: () {
                    print('Icon search');
                  },
                  icon: Icons.search),
              PinteresBottomModel(
                  onPressed: () {
                    print('Icon notifications');
                  },
                  icon: Icons.notifications),
              PinteresBottomModel(
                  onPressed: () {
                    print('Icons supervised_user_circle');
                  },
                  icon: Icons.supervised_user_circle),
                  PinteresBottomModel(onPressed:(){}, icon: Icons.emoji_people)
            ],
          )),
        ));
  }
}

class PinterestGrid extends StatefulWidget {
  const PinterestGrid({
    super.key,
  });

  @override
  State<PinterestGrid> createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  ScrollController controller = ScrollController();
  double lastScroll = 0;
  @override
  void initState() {
    controller.addListener(() {
      if (controller.offset > lastScroll &&
          (controller.offset - lastScroll) >= 100) {
        Provider.of<_MenuModel>(context, listen: false).show = false;
        lastScroll = controller.offset;
      }
      if (controller.offset < lastScroll &&
          (lastScroll - controller.offset) >= 100) {
        Provider.of<_MenuModel>(context, listen: false).show = true;
        lastScroll = controller.offset;
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
    final List<int> items = List.generate(200, (index) => index);
    return StaggeredGridView.countBuilder(
      controller: controller,
      crossAxisCount: 4,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) =>
          PinterestItem(index: index),
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 2 : 3),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

class PinterestItem extends StatelessWidget {
  final int index;
  const PinterestItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text('$index'),
          ),
        ));
  }
}

class _MenuModel with ChangeNotifier {
  bool _show = true;
  bool get show => _show;

  set show(bool value) {
    _show = value;
    notifyListeners();
  }
}
