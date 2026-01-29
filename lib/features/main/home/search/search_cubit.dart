import 'package:chatbox/data/models/friends/friend_entity.dart';
import 'package:chatbox/features/main/home/search/search_state.dart';
import 'package:chatbox/repository/friend_repository.dart';
import 'package:chatbox/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  final UserRepository userRepository;
  final FriendRepository friendRepository;

  SearchCubit({required this.userRepository, required this.friendRepository}) : super(SearchState());

  void searchUsers(String query) async {
    final users = await userRepository.searchUsersByNameOrEmail(query);
    emit(state.copyWith(listUsers: users['non_friend']));
  }

  void addFriend(String uid) async {

  }

}
