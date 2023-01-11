import 'dart:io';

import 'package:asrar_control_panel/features/home/domain/repositories/file_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';

class UploadFileUseCase {
  final FileRepository imageRepository;

  UploadFileUseCase(this.imageRepository);

  Future<Either<Failure, Unit>> call(
      File file, String fileName, String filePath) async {
    return await imageRepository.uploadFile(file, fileName, filePath);
  }
}
