import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final Color backgroundColor;
  final Color iconColor;

  const AppBarWidget({
    super.key,
    this.onBack,
    this.actions,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: iconColor),
        onPressed: onBack ?? () => Navigator.of(context).pop(),
      ),
      actions: actions,
    );
    ;
  }
}
