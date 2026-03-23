import 'package:chatbox/core/base/base_navigator.dart';
import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:chatbox/navigation/app_router.dart';
import 'package:go_router/go_router.dart';

class ContactsNavigator extends BaseNavigator {
  ContactsNavigator({required super.context});

  void goToSearchPage() {
    context.pushNamed(AppRouter.searchName);
  }

  void goToFriendProfile(UserEntity friend) {
    context.pushNamed(AppRouter.friendProfileRouteName, extra: friend);
  }
}
