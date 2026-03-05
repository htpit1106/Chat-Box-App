import 'package:chatbox/data/repository/friend_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'contacts_navigator.dart';
import 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  final FriendRepository friendRepos;
  final ContactsNavigator navigator;
  ContactsCubit({required this.friendRepos, required this.navigator})
    : super(ContactsState());
  void init() {
    getContacts();
  }

  void getContacts() async {
    final contacts = await friendRepos.getContacts();
    emit(state.copyWith(contacts: contacts));
  }

  void navigateToSearch() {
    navigator.goToSearchPage();
  }
}
