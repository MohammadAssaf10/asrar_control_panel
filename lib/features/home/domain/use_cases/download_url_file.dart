import 'package:firebase_storage/firebase_storage.dart';

import '../repositories/file_repository.dart';

class DownloadUrlFileUseCase{
  final FileRepository imageRepository;

  DownloadUrlFileUseCase(this.imageRepository);

  Future<List<String>> call(List<Reference> refs) async {
    return await imageRepository.downloadUrlFile(refs);
  }
}