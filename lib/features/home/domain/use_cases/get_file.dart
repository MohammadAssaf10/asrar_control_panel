import 'package:asrar_control_panel/features/home/domain/repositories/image_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/file_entities.dart';

class GetFileUseCase {
  final ImageRepository imageRepository;

  GetFileUseCase(this.imageRepository);

  Future<Either<Failure, List<FileEntities>>> call(String folderName) async {
    return await imageRepository.getFile(folderName);
  }
}
