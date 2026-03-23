import 'package:chatbox/core/constants/key_constants.dart';
import 'package:chatbox/core/error/failures.dart';
import 'package:chatbox/data/models/conversation/conversation_entity.dart';
import 'package:chatbox/data/models/entity/friends/friend_entity.dart';
import 'package:chatbox/data/models/entity/message/message_entity.dart';
import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:chatbox/data/models/params/send_file_param.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ConversationRepository {
  Future<Either<Failure, String>> createConversation({
    required ConversationEntity conversation,
    required List<String> memberIds,
  });

  Future<List<ConversationEntity>> getChattedConversations(
    List<UserEntity> friends,
  );

  // get all message
  Stream<Either<Failure, List<MessageEntity>>> getMessages(
    String conversationId,
  );

  // send message
  Future<Either<Failure, void>> sendMessage({
    required MessageEntity message,
    required String conversationId,
  });

  // get conversation id
  Future<Either<Failure, String>> getConversationId(String friendId);

  Future<void> sendFile({required SendFileParam param});
}

class ConversationRepositoryImpl implements ConversationRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final currentUid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Future<Either<Failure, String>> createConversation({
    required ConversationEntity conversation,
    required List<String> memberIds,
  }) async {
    try {
      // create conversation

      // 1.
      final conversationRef = _firestore.collection('conversations').doc();
      final newConversationId = conversationRef.id;
      await _firestore
          .collection('conversations')
          .doc(newConversationId)
          .set(conversation.toJson());

      // 2.  // update conversationId for each friend member
      for (final memberId in memberIds) {
        if (memberId == currentUid) continue;

        await _firestore
            .collection('users')
            .doc(memberId)
            .collection('friends')
            .doc(currentUid)
            .update({'conversation_id': newConversationId});

        await _firestore
            .collection('users')
            .doc(currentUid)
            .collection('friends')
            .doc(memberId)
            .update({'conversation_id': newConversationId});
      }
      print("currentUid: $currentUid");
      return Right(newConversationId);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<List<ConversationEntity>> getChattedConversations(
    List<UserEntity> friends,
  ) async {
    // 1.
    if (currentUid == null) return [];
    final List<ConversationEntity> conversations = [];
    for (final friend in friends) {
      if (friend.uid == null) continue;

      // get conversaId from friends - sub-collection of users
      final friendDoc = await _firestore
          .collection('users')
          .doc(currentUid)
          .collection('friends')
          .doc(friend.uid)
          .get();
      final data = FriendEntity.fromFireStore(friendDoc);
      final conversationId = data.conversationId;
      if (conversationId == null || conversationId.isEmpty) continue;

      // get conversation from conversationId
      final conversationDoc = await _firestore
          .collection('conversations')
          .doc(conversationId)
          .get();
      if (conversationDoc.data() == null) continue;
      final conversation = ConversationEntity.fromFireStore(conversationDoc);
      conversations.add(conversation);
    }
    return conversations;
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required MessageEntity message,
    required String conversationId,
  }) async {
    try {
      final messagesRef = _firestore
          .collection(KeyConstants.collectionConversations)
          .doc(conversationId)
          .collection(KeyConstants.collectionMessages);
      await messagesRef.add(message.toJson());

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<MessageEntity>>> getMessages(
    String conversationId,
  ) {
    try {
      final stream = _firestore
          .collection(KeyConstants.collectionConversations)
          .doc(conversationId)
          .collection(KeyConstants.collectionMessages)
          .orderBy("created_at", descending: false) // quan trọng
          .snapshots();

      return stream.map((snapshot) {
        final messages = snapshot.docs
            .map((doc) => MessageEntity.fromJson(doc.data()))
            .toList();

        return Right(messages);
      });
    } catch (e) {
      return Stream.value(Left(ServerFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, String>> getConversationId(String friendId) async {
    try {
      if (currentUid == null)
        return Future.value(Left(ServerFailure(message: 'User not found')));
      final res = _firestore
          .collection('users')
          .doc(currentUid)
          .collection('friends')
          .doc(friendId)
          .get();
      final data = res.then((value) => value.data());
      final conversationId = data.then((value) => value?['conversation_id']);
      return Future.value(Right(await conversationId));
    } catch (e) {
      return Future.value(Left(ServerFailure(message: e.toString())));
    }
  }

  @override
  Future<void> sendFile({required SendFileParam param}) {
    // TODO: implement sendFile
    throw UnimplementedError();
  }
}
