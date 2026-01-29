import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget  {
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final Color backgroundColor;
  final Color iconColor;
  final Widget? title;
  final TextStyle? titleStyle;

  const AppBarWidget({
    super.key,
    this.onBack,
    this.actions,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.titleStyle,
    this.title
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: false,
      title: title,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: iconColor),
        onPressed: onBack ?? () => Navigator.of(context).pop(),
      ),
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
