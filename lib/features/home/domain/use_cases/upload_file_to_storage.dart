import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/data/failure.dart';
import '../repositories/storage_file_repository.dart';

class UploadFileToStorageUseCase {
  final StorageFileRepository fileRepository;

  UploadFileToStorageUseCase({required this.fileRepository});

  Future<Either<Failure, UploadTask>> call(
      Uint8List file, String fileName, String folderPath) async {
    return await fileRepository.uploadFile(file, fileName, folderPath);
  }
}
