import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/data/failure.dart';
import '../entities/xfile_entities.dart';
import '../repositories/storage_file_repository.dart';

class UploadFileToStorageUseCase {
  final StorageFileRepository fileRepository;

  UploadFileToStorageUseCase({required this.fileRepository});

  Future<Either<Failure, UploadTask>> call(
      XFileEntities xFileEntities, String folderPath) async {
    return await fileRepository.uploadFile(xFileEntities, folderPath);
  }
}
