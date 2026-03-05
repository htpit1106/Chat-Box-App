import 'package:chatbox/data/models/user_profile/user_entity.dart';
import 'package:equatable/equatable.dart';

class ContactsState extends Equatable {
  final List<UserEntity> contacts;
  const ContactsState({this.contacts = const []});

  // copy with
  ContactsState copyWith({List<UserEntity>? contacts}) {
    return ContactsState(contacts: contacts ?? this.contacts);
  }

  @override
  List<Object?> get props => [contacts];
}
