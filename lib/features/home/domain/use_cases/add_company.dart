import 'package:asrar_control_panel/core/data/failure.dart';
import 'package:asrar_control_panel/core/data/firebase_exception_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/app/di.dart';

class AddCompanyUseCase {
  Future<Either<Failure, Unit>> call(
      String folderName, String fileName) async {
    try {
      final FirebaseFirestore db = instance<FirebaseFirestore>();
      final Reference storageRef = instance<Reference>();
      String url =
          await storageRef.child("$folderName/$fileName").getDownloadURL();
      db
          .collection(folderName)
          .doc(fileName)
          .set({"name": fileName, "image": url});
      return const Right(unit);
    } catch (e) {
      return Left(FirebaseExceptionHandler.handle(e).getFailure());
    }
  }
}
