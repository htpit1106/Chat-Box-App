import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppRefresher extends StatelessWidget {
  final RefreshController controller;
  final Widget child;
  final bool? enablePullUP;
  final Axis? scrollDirection;
  final ScrollController? scrollController;
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoading;

  const AppRefresher({
    super.key,
    required this.controller,
    required this.child,
    this.enablePullUP,
    this.scrollDirection,
    this.scrollController,
    this.onRefresh,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      header: const ClassicHeader(),
      controller: controller,
      scrollController: scrollController,
      enablePullUp: enablePullUP ?? true,
      scrollDirection: scrollDirection,
      onRefresh: () async {
        if (onRefresh != null) {
          await onRefresh!();
        }
        controller.refreshCompleted();
      },
      onLoading: () async {
        if (onLoading != null) {
          await onLoading!();
        }
        controller.loadComplete();
      },
      child: child,
    );
  }
}
