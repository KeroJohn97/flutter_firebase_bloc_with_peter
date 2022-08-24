import 'package:flutter/material.dart';
import 'package:flutter_firebase_bloc_with_peter/helpers/color_helper.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final bool hasLeading;
  final Color color;
  final Color iconColor;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions = const [],
    this.hasLeading = true,
    this.color = ColorHelper.themeColor,
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      elevation: 0.0,
      leading: hasLeading
          ? Padding(
              padding: const EdgeInsets.all(4.0),
              child: Material(
                color: color,
                shape: const CircleBorder(),
                child: InkResponse(
                  radius: 18.0,
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: iconColor,
                    size: 18.0,
                  ),
                ),
              ),
            )
          : null,
      actions: actions,
      centerTitle: true,
      title: Text(title.tr),
    );
  }
}
