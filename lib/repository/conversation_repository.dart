import 'package:chatbox/data/models/conversation/conversation_entity.dart';
import 'package:chatbox/data/models/friends/friend_entity.dart';
import 'package:chatbox/data/models/user_profile/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ConversationRepository {
  Future<void> createConversation({
    required ConversationEntity conversation,
    required List<String> memberIds,
  });
  Future<List<ConversationEntity>> getChattedConversations(List<UserEntity> friends);
}

class ConversationRepositoryImpl implements ConversationRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final currentUid = FirebaseAuth.instance.currentUser?.uid;


  @override
  Future<void> createConversation({
    required ConversationEntity conversation,
    required List<String> memberIds,
  }) async {
    // 0. check if conversation exist - at friends - conversationId;
    // 1. create conversation
    // 3.     // add conversationId to field 'conversation_id' in friends <sub-collection of users>

    // 0.
    if (currentUid == null) return;
    final friendDoc = await _firestore
        .collection('users')
        .doc(currentUid)
        .collection('friends')
        .doc(memberIds[0])
        .get();
    final data = friendDoc.data();
    final conversationId = data?['conversation_id'];
    if (conversationId != null) return;


    // 1.
    final conversationRef =
    _firestore.collection('conversations').doc();
    final newConversationId = conversationRef.id;
   await _firestore
        .collection('conversations')
        .doc(newConversationId)
        .set(conversation.toJson());

    // 2.
     _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('friends')
        .doc(memberIds[0])
        .update({'conversation_id': newConversationId});
  }

  @override
  Future<List<ConversationEntity>> getChattedConversations(List<UserEntity> friends)  async {
    // 1.
    if (currentUid == null) return [];
    final List<ConversationEntity> conversations = [];
    for (final friend in friends){
      if (friend.uid == null) continue;

      // get conversaId from friends - sub-collection of users
      final friendDoc = await _firestore
          .collection('users')
          .doc(currentUid)
          .collection('friends').doc(friend.uid).get();
      final data = FriendEntity.fromFireStore(friendDoc);
      final conversationId = data.conversationId;
      if (conversationId == null) continue;

      // get conversation from conversationId
      final conversationDoc = await _firestore.collection('conversations').doc(conversationId).get();
      final conversation = ConversationEntity.fromFireStore(conversationDoc);
      conversations.add(conversation);

    }
    return conversations;
  }


}
