import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/widget/big_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButtonExist;
  final Function? onBackPressed;
  final List<Widget>? actions;

  CustomAppBar(
      {super.key,
      required this.title,
      this.backButtonExist = true,
      this.onBackPressed,
      this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BigText(
        text: title,
        color: Colors.white,
      ),
      backgroundColor: AppColors.mainColor,
      centerTitle: true,
      elevation: 0,
      leading: backButtonExist
          ? IconButton(
              onPressed: () => onBackPressed != null
                  ? onBackPressed!()
                  : Navigator.pushReplacementNamed(context, "/initial"),
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
            )
          : SizedBox(),
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(500, 50);
}
