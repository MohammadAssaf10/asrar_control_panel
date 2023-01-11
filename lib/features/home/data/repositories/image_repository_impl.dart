import 'dart:io';

import 'package:asrar_control_panel/core/data/failure.dart';
import 'package:asrar_control_panel/features/home/domain/repositories/image_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/firebase_exception_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/file_entities.dart';

class ImageRepositoryImpl implements ImageRepository {
  final FirebaseStorage storage;
  final NetworkInfo networkInfo;

  ImageRepositoryImpl({required this.storage, required this.networkInfo});

  @override
  Future<List<String>> downloadUrlFile(List<Reference> refs) async =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  @override
  Future<Either<Failure, Unit>> uploadFile(
      File file, String fileName, String filePath) async {
    if (await networkInfo.isConnected) {
      try {
        final String path = "$filePath/$fileName";
        final Reference storageRef = storage.ref();
        final Reference ref = storageRef.child(path);
        ref.putFile(file);
        return Right(unit);
      } catch (e) {
        return Left(FirebaseExceptionHandler.handle(e).getFailure());
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<FileEntities>>> getFile(String folderName) async {
    if (await networkInfo.isConnected) {
      try {
        final Reference ref = storage.ref(folderName);
        final ListResult result = await ref.listAll();
        final List<String> urls = await downloadUrlFile(result.items);
        return Right(urls
            .asMap()
            .map((key, value) {
              final ref = result.items[key];
              final fileName = ref.name;
              final FileEntities file =
                  FileEntities(name: fileName, url: value);
              return MapEntry(key, file);
            })
            .values
            .toList());
      } catch (e) {
        return Left(FirebaseExceptionHandler.handle(e).getFailure());
      }
    } else
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
  }
}
