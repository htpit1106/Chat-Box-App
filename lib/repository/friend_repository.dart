import '../data/models/friends/friend_entity.dart';

abstract class FriendRepository {
  // list friends online
  Future<List<FriendEntity>> getFriendsOnline();
  Future<void> addFriend(String uid);
}