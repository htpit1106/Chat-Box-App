import 'package:chatbox/data/repository/friend_repository.dart';
import 'package:chatbox/data/repository/user_repository.dart';
import 'package:chatbox/features/main/home/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';

class SearchCubit extends Cubit<SearchState> {
  final UserRepository userRepository;
  final FriendRepository friendRepository;
  final Debouncer debouncer = Debouncer();
  SearchCubit({required this.userRepository, required this.friendRepository})
    : super(SearchState());

  void searchUsers(String query) async {
    debouncer.debounce(
      duration: Duration(seconds: 1),
      onDebounce: () async {
        final users = await userRepository.searchUsersByNameOrEmail(query);
        emit(
          state.copyWith(
            listNonFriend: users['non_friend'],
            listFriends: users['friend'],
          ),
        );
      },
    );
  }

  void addFriend(String uid, String query) async {
    await friendRepository.addFriend(uid);
    searchUsers(query);
  }
}
