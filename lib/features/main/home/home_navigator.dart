import 'package:chatbox/core/base/base_navigator.dart';
import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:chatbox/navigation/app_router.dart';
import 'package:go_router/go_router.dart';

class HomeNavigator extends BaseNavigator {
  HomeNavigator({required super.context});

  void openMessagePage(UserEntity user) {
    context.pushNamed(AppRouter.messageName, extra: user);
  }

  void openSearchPage() {
    context.pushNamed(AppRouter.searchName);
  }
}
