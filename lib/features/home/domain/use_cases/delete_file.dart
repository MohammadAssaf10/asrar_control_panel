import 'package:asrar_control_panel/features/home/domain/repositories/file_repository.dart';

class DeleteFileUseCase {
  final FileRepository fileRepository;

  DeleteFileUseCase({required this.fileRepository});

  Future<void> call(String folderName, String fileName) {
    return fileRepository.deleteFile(folderName, fileName);
  }
}
