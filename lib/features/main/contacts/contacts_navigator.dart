import 'package:chatbox/core/base/base_navigator.dart';
import 'package:chatbox/navigation/app_router.dart';
import 'package:go_router/go_router.dart';

class ContactsNavigator extends BaseNavigator {
  ContactsNavigator({required super.context});
  void goToSearchPage() {
    context.pushNamed(AppRouter.searchName);
  }
}
