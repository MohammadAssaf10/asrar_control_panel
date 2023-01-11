import 'package:firebase_storage/firebase_storage.dart';

import '../repositories/image_repository.dart';

class DownloadUrlFileUseCase{
  final ImageRepository imageRepository;

  DownloadUrlFileUseCase(this.imageRepository);

  Future<List<String>> call(List<Reference> refs) async {
    return await imageRepository.downloadUrlFile(refs);
  }
}