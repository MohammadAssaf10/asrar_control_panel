import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/file_entities.dart';
import '../repositories/storage_file_repository.dart';

class GetStorageFileUseCase {
  final StorageFileRepository imageRepository;

  GetStorageFileUseCase({required this.imageRepository});

  Future<Either<Failure, List<FileEntities>>> call(String folderName) async {
    return await imageRepository.getFile(folderName);
  }
}
