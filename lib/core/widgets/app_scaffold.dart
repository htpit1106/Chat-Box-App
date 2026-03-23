import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:chatbox/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget? header;
  final Widget? body;

  const AppScaffold({super.key, this.header, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Column(
        spacing: 20,
        children: [
          SafeArea(child: header ?? Container()),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 2,
                    child: VerticalDivider(
                      color: AppColors.greyCD,
                      thickness: 30,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: 8.paddingHorizontal,
                      child: body ?? Container(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
