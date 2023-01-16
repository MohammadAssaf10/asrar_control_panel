import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/data/failure.dart';
import '../entities/file_entities.dart';
import '../entities/xfile_entities.dart';

abstract class StorageFileRepository {
  Future<Either<Failure, UploadTask>> uploadFile(
      XFileEntities xFileEntities, String folderPath);

  Future<Either<Failure, List<FileEntities>>> getFile(String folderName);
  Future<void> deleteFile(String folderName,String fileName);
}
