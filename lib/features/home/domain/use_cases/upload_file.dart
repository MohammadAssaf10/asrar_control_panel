import 'package:asrar_control_panel/features/home/domain/repositories/file_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/data/failure.dart';

class UploadFileUseCase {
  final FileRepository fileRepository;

  UploadFileUseCase(this.fileRepository);

  Future<Either<Failure, UploadTask>> call(
      Uint8List file, String fileName, String filePath) async {
    return await fileRepository.uploadFile(file, fileName, filePath);
  }
}
