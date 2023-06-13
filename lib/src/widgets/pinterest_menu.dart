import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestMenu extends StatelessWidget {
  final List<PinteresBottomModel> items;
  final bool show;
  final Color colorIconSelected;
  final Color colorIcon;
  const PinterestMenu(
      {Key? key,
      required this.show,
      this.colorIconSelected = Colors.blue,
      this.colorIcon = Colors.grey, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return _MenuModel();
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: (show) ? 1 : 0,
        child: Builder(
          builder: (context) {
            Provider.of<_MenuModel>(context).colorIcon = colorIcon;
            Provider.of<_MenuModel>(context).colorIconSelected = colorIconSelected;
            return Container(
              width: 250,
              height: 60,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38, blurRadius: 10, spreadRadius: -5)
                  ]),
              child: _ItemsMenu(items: items),
            );
          },
        ),
      ),
    );
  }
}

class _ItemsMenu extends StatelessWidget {
  final List<PinteresBottomModel> items;
  const _ItemsMenu({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
          items.length,
          (index) => _PinterestMenuBottom(
                index: index,
                item: items[index],
              )),
    );
  }
}

class _PinterestMenuBottom extends StatelessWidget {
  final int index;
  final PinteresBottomModel item;
  const _PinterestMenuBottom({
    super.key,
    required this.index,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final menuModel = Provider.of<_MenuModel>(context);
    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).selectedItem = index;
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
          child: Icon(
        item.icon,
        size: (menuModel.selectedItem == index) ? 35 : 25,
        color: (menuModel.selectedItem == index) ? menuModel.colorIconSelected : menuModel.colorIcon,
      )),
    );
  }
}

class PinteresBottomModel {
  final Function onPressed;
  final IconData icon;

  PinteresBottomModel({required this.onPressed, required this.icon});
}

class _MenuModel with ChangeNotifier {
  int _selectedItem = 0;
  Color colorIconSelected = Colors.blue;
  Color colorIcon = Colors.grey;
  Color get getColorIconSelected => colorIconSelected;

  set setColorIconSelected(Color colorIconSelected) {
    colorIconSelected = colorIconSelected;
    notifyListeners();
  }

  get getColorIcon => colorIcon;

  set setColorIcon(colorIcon) {
    colorIcon = colorIcon;
    notifyListeners();
  }

  int get selectedItem => _selectedItem;

  set selectedItem(int value) {
    _selectedItem = value;
    notifyListeners();
  }
}
