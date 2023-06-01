// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.icon, this.text});
  Widget? icon;
  String? text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    Key? key,
    required this.items,
    this.centerItemText,
    this.height = 70.0,
    this.iconSize = 30,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    required this.onTabSelected,
    this.isNestedBottomBar = false,
  }) : super(key: key) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final String? centerItemText;
  final double? height;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final NotchedShape? notchedShape;
  final ValueChanged<int> onTabSelected;
  final bool? isNestedBottomBar;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return Container(
      padding: const EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomAppBar(
          elevation: 0.0,
          shape: widget.notchedShape,
          notchMargin: 4.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items,
          ),
          color: widget.backgroundColor,
        ),
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
//        height: 10,
        child: SizedBox(height: widget.iconSize),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem? item,
    int? index,
    ValueChanged<int>? onPressed,
  }) {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: widget.isNestedBottomBar!
                ? () {
                    onPressed!(index!);
                    setState(() {
                      _selectedIndex = index;
                    });
                    // Get.offAll(AppDrawer(
                    //   child: RootScreen(),
                    // ));
                  }
                : () => onPressed!(index!),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                item!.icon!,
                index == _selectedIndex
                    ? Container(
                        height: 7.h,
                      )
                    : Container(),
                index == _selectedIndex
                    ? Container(
                        height: 6.r,
                        width: 6.r,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
