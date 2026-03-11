import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:chatbox/core/theme/app_colors.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/divider/app_divider.dart';
import 'package:flutter/material.dart';

class AppDialog {
  final BuildContext _context;

  AppDialog(this._context);

  void hide({dynamic result}) => Navigator.pop(_context, result);

  Future<void> show({
    String message = "",
    String? textConfirm = "OK",
    String? textCancel,
    TextStyle? textMessageStyle,
    barrierDismissible = false,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool? centerTitle,
  }) {
    return showDialog<void>(
      context: _context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.greyCD,
          shape: RoundedRectangleBorder(borderRadius: 14.radius),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: 270,
            decoration: BoxDecoration(
              color: AppColors.greyCD,
              borderRadius: 14.radius,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Offstage(
                  offstage: message.isEmpty,
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 48),
                        child: Padding(
                          padding: 16.paddingAll,
                          child: Center(
                            child: Text(
                              message,
                              style:
                                  textMessageStyle ??
                                  AppTextStyle.black.s14.w300,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const AppDivider(),
                SizedBox(
                  width: double.maxFinite,
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        if (textCancel != null ||
                            (textCancel?.isNotEmpty ?? false)) ...{
                          Expanded(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(minHeight: 48),
                              child: TextButton(
                                onPressed: () {
                                  if (onCancel == null) {
                                    Navigator.of(context).pop();
                                    return;
                                  }
                                  onCancel.call();
                                },
                                child: Text(
                                  textCancel ?? "Cancel",
                                  style: AppTextStyle.primary.s14.w700,
                                ),
                              ),
                            ),
                          ),
                        },
                        Offstage(
                          offstage:
                              textConfirm == null ||
                              textConfirm.isEmpty ||
                              textCancel == null ||
                              textCancel.isEmpty,
                          child: Container(width: 1, color: AppColors.divider),
                        ),
                        if (textConfirm != null ||
                            (textConfirm?.isNotEmpty ?? false)) ...{
                          Expanded(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(minHeight: 48),
                              child: TextButton(
                                onPressed: () {
                                  if (onConfirm == null) {
                                    Navigator.of(context).pop();
                                    return;
                                  }
                                  onConfirm.call();
                                },
                                child: Text(
                                  textConfirm ?? "OK",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.primary.s14.w700,
                                ),
                              ),
                            ),
                          ),
                        },
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
