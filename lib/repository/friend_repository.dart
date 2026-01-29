import '../data/models/friends/friend_entity.dart';

abstract class FriendRepository {
  Future<List<FriendEntity>> getFriendsOnline();
  Future<void> addFriend(String uid);
}

class FriendRepositoryImpl implements FriendRepository {
  @override
  Future<void> addFriend(String uid) {
    // TODO: implement addFriend
    throw UnimplementedError();
  }

  @override
  Future<List<FriendEntity>> getFriendsOnline() {
    // TODO: implement getFriendsOnline
    throw UnimplementedError();
  }
  
}