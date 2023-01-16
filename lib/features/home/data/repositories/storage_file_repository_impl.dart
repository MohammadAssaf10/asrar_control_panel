import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/entities/file_entities.dart';
import '../../domain/entities/xfile_entities.dart';
import '../../domain/repositories/storage_file_repository.dart';

class StorageFileRepositoryImpl implements StorageFileRepository {
  final FirebaseStorage storage;

  StorageFileRepositoryImpl({required this.storage});

  Future<List<String>> downloadUrlFile(List<Reference> refs) async =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  @override
  Future<Either<Failure, Unit>> uploadFile(
      XFileEntities xFileEntities, String folderPath) async {
    try {
      final String path = "$folderPath/${xFileEntities.name}";
      final Reference storageRef = storage.ref();
      final Reference ref = storageRef.child(path);
      final UploadTask task = ref.putData(xFileEntities.xFileAsBytes);
      await task.whenComplete(() {});
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<FileEntities>>> getFile(String folderName) async {
    try {
      final Reference ref = storage.ref(folderName);
      final ListResult result = await ref.listAll();
      final List<String> urls = await downloadUrlFile(result.items);
      return Right(urls
          .asMap()
          .map((key, value) {
            final ref = result.items[key];
            final fileName = ref.name;
            final FileEntities file = FileEntities(name: fileName, url: value);
            return MapEntry(key, file);
          })
          .values
          .toList());
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<void> deleteFile(String folderName, String fileName) async {
    final ref = storage.ref().child("$folderName/$fileName");
    await ref.delete();
  }
}
