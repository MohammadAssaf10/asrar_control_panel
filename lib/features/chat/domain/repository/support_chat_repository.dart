import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/data/failure.dart';
import '../entities/message.dart';

abstract class SupportChatRepository{
  Future<Either<Failure,List<Sender>>> getSender();
  Future<Either<Failure, Stream<List<Message>>>> getSupportChat(String senderId);
  Future<Either<Failure, void>> sendMessage(Message message,String docId);
  Future<Either<Failure, String>> uploadImage(XFile image);
}