import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/data/failure.dart';
import '../entities/file_entities.dart';

abstract class FileRepository {
  Future<Either<Failure, UploadTask>> uploadFile(
      Uint8List file, String fileName, String filePath);

  Future<Either<Failure, List<FileEntities>>> getFile(String folderName);
  Future<void> deleteFile(String folderName,String fileName);
}
