import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    Key? key,
    @required this.items,
    this.onTap,
    this.currentIndex,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.iconSize = 50,
  }) : super(key: key);

  final ValueChanged<int>? onTap;
  final int? currentIndex;
  final List<AppBottomNavigationBarItem>? items;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    List<Widget> _tile = <Widget>[];
    for (int i = 0; i < items!.length; i++) {
      _tile.add(
        _AppBottomNavigationBarItemTile(
          items![i],
          onItemTap: () {
            if (onTap != null) onTap!(i);
          },
          selected: i == currentIndex!,
        ),
      );
    }
    return BottomAppBar(
      color: const Color(
        0XFFFFFFFF,
      ),
      child: Material(
        color: const Color(0xFFFBFBFB),
        elevation: 0.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _tile,
        ),
      ),
    );
  }
}

class _AppBottomNavigationBarItemTile extends StatelessWidget {
  const _AppBottomNavigationBarItemTile(
    this.item, {
    this.onItemTap,
    this.selected,
  });

  final AppBottomNavigationBarItem item;
  final VoidCallback? onItemTap;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 80,
        child: GestureDetector(
          onTap: onItemTap,
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppBottomIcon(
                  imageName: item.customIcon,
                  isActive: selected,
                  hasCustomIcon: item.useCustomIcon,
                  icon: item.icon,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  item.label!,
                  style: CsTextStyle.caption.copyWith(
                    color: selected! ? CsColors.primary : CsColors.primaryText,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppBottomIcon extends StatelessWidget {
  const AppBottomIcon({
    Key? key,
    this.imageName,
    this.isActive,
    this.hasCustomIcon,
    this.icon,
  }) : super(key: key);

  final String? imageName;
  final bool? isActive;
  final bool? hasCustomIcon;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (hasCustomIcon!) {
      return SvgPicture.asset(
        imageName!,
        width: 24,
        height: 24,
        fit: BoxFit.cover,
        color: isActive! ? CsColors.primary : const Color(0xFFB1B1B1),
      );
    } else {
      return Icon(
        icon,
        size: 27,
        color: isActive! ? CsColors.primary : const Color(0xFFB1B1B1),
      );
    }
  }
}

class AppBottomNavigationBarItem {
  AppBottomNavigationBarItem({
    this.customIcon,
    String? label,
    this.icon,
    this.useCustomIcon = true,
  }) : label = label ?? '';

  final String? customIcon;
  final bool? useCustomIcon;
  final String? label;
  final IconData? icon;
}
