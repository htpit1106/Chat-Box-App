import 'package:chatbox/core/base/base_navigator.dart';
import 'package:chatbox/navigation/app_router.dart';
import 'package:go_router/go_router.dart';

class HomeNavigator extends BaseNavigator{
  HomeNavigator({required super.context});
  void openMessagePage(){
    context.pushNamed(AppRouter.messageName);
  }
  void openSearchPage(){
    context.pushNamed(AppRouter.searchName);
  }
}