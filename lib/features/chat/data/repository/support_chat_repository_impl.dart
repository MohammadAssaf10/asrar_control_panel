import 'package:asrar_control_panel/core/data/failure.dart';

import 'package:asrar_control_panel/features/chat/domain/entities/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/app/functions.dart';
import '../../../../core/data/exception_handler.dart';
import '../../domain/repository/support_chat_repository.dart';

class SupportChatRepositoryImpl extends SupportChatRepository {
  final FirebaseFirestore firestore;
  final Sender? sender;
  final DocumentReference supportChatReference;

  SupportChatRepositoryImpl({this.sender, required this.firestore})
      : supportChatReference = firestore
            .collection(FireBaseCollection.supportChat)
            .doc(sender?.id);

  @override
  Future<Either<Failure, List<Sender>>> getSender() async {
    try {
      List<Sender> senderList = [];
      final messageDetailsSnapshot =
          await firestore.collection(FireBaseCollection.supportChat).get();
      for (var doc in messageDetailsSnapshot.docs) {
        senderList.add(Sender.fromMap(doc.data()));
      }
      return Right(senderList);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(
      Message message, String docId) async {
    try {
      await firestore
          .collection(FireBaseCollection.supportChat)
          .doc(docId)
          .collection(FireBaseCollection.supportChat)
          .add(message.toMap());
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(XFile image) async {
    try {
      var file = await uploadFile(
          '${FireBaseCollection.supportChat}/${sender?.id}/images/${image.name}',
          image);
      print(file.url);
      return Right(file.url);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Stream<List<Message>>>> getSupportChat(
      String senderId) async {
    try {
      final supportChat =
          firestore.collection(FireBaseCollection.supportChat).doc(senderId);
      return Right(supportChat
          .collection(FireBaseCollection.supportChat)
          .snapshots()
          .map(
        (event) {
          List<Message> list = [];
          for (var doc in event.docs) {
            list.add(Message.fromMap(doc.data()));
          }
          return list;
        },
      ));
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
