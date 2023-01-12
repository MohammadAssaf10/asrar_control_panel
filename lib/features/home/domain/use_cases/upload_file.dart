import 'package:asrar_control_panel/features/home/domain/repositories/file_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/data/failure.dart';

class UploadFileUseCase {
  final FileRepository imageRepository;

  UploadFileUseCase(this.imageRepository);

  Future<Either<Failure, Unit>> call(
      Uint8List file, String fileName, String filePath) async {
    return await imageRepository.uploadFile(file, fileName, filePath);
  }
}
