import '../repositories/storage_file_repository.dart';

class DeleteStorageFileUseCase {
  final StorageFileRepository fileRepository;

  DeleteStorageFileUseCase({required this.fileRepository});

  Future<void> call(String folderName, String fileName) async{
    return await fileRepository.deleteFile(folderName, fileName);
  }
}
