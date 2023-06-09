import 'package:client_user/material/bilions_ui.dart';
import 'package:client_user/material/color/app_colors.dart';
import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  final List<MenuListItem> list;
  final Color? lineColor;
  final double? lineThickness;
  const MenuList(
    this.list, {
    Key? key,
    this.lineColor,
    this.lineThickness,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...list.map((MenuListItem list) => _list(list)).toList(),
      ],
    );
  }

  _list(MenuListItem list) {
    return InkWell(
      onTap: list.onPressed,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: BilionsColors.primaryLight,
                    borderRadius: const BorderRadius.all(Radius.circular(300)),
                  ),
                  child: list.icon,
                ),
                mr(1),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      H(list.title.toUpperCase()),
                      if (list.subTitle != null)
                        Span(
                          list.subTitle,
                          color: BilionsColors.grey,
                          size: 13,
                        )
                    ],
                  ),
                ),
                list.subFixIcon ??
                    Icon(Icons.chevron_right, color: BilionsColors.primary)
              ],
            ),
          ),
          horizontalLine(color: lineColor, thickness: lineThickness),
        ],
      ),
    );
  }
}

class MenuListItem {
  final String title;
  final String? subTitle;
  final Widget icon;
  final Widget? subFixIcon;
  final Function()? onPressed;

  const MenuListItem(
    this.icon, {
    this.subTitle,
    this.onPressed,
    this.subFixIcon,
    required this.title,
  });
}
