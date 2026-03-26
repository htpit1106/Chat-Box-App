import 'package:chatbox/core/constants/key_constants.dart';
import 'package:chatbox/core/error/failures.dart';
import 'package:chatbox/data/models/entity/conversation_entity.dart';
import 'package:chatbox/data/models/entity/friends/friend_entity.dart';
import 'package:chatbox/data/models/entity/message/message_entity.dart';
import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ConversationRepository {
  Future<Either<Failure, String>> createConversation({
    required ConversationEntity conversation,
    required List<String> memberIds,
  });

  Future<Either<Failure, void>> updateConversation(
    ConversationEntity conversation,
  );

  Stream<Either<Failure, List<ConversationEntity>>> getChattedConversations(
    List<UserEntity> friends,
  );

  Stream<Either<Failure, List<MessageEntity>>> getMessages(
    String conversationId,
  );

  Future<Either<Failure, void>> sendMessage({
    required MessageEntity message,
    required String conversationId,
  });

  Future<Either<Failure, String>> getConversationId(String friendId);
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
      conversation = conversation.copyWith(id: newConversationId);
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
      return Right(newConversationId);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<ConversationEntity>>> getChattedConversations(
    List<UserEntity> friends,
  ) {
    if (currentUid == null) {
      return Stream.value(Left(ServerFailure(message: 'User not found')));
    }

    return _firestore
        .collection('users')
        .doc(currentUid)
        .collection('friends')
        .snapshots()
        .asyncMap((snapshot) async {
          try {
            final futures = snapshot.docs.map((doc) async {
              final data = FriendEntity.fromFireStore(doc);
              final conversationId = data.conversationId;

              if (conversationId == null || conversationId.isEmpty) return null;

              final conversationDoc = await _firestore
                  .collection('conversations')
                  .doc(conversationId)
                  .get();

              if (!conversationDoc.exists) return null;

              return ConversationEntity.fromFireStore(conversationDoc);
            });

            final results = await Future.wait(futures);

            return Right(results.whereType<ConversationEntity>().toList());
          } catch (e) {
            return Left(ServerFailure(message: e.toString()));
          }
        });
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
      if (currentUid == null) {
        return Future.value(Left(ServerFailure(message: 'User not found')));
      }
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
  Future<Either<Failure, void>> updateConversation(
    ConversationEntity conversation,
  ) async {
    try {
      final conversationRef = _firestore
          .collection('conversations')
          .doc(conversation.id);
      await conversationRef.update(conversation.toJonUpdate());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
