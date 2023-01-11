import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/data/failure.dart';
import '../entities/file_entities.dart';

abstract class ImageRepository {
  Future<Either<Failure, Unit>> uploadFile(
      File file, String fileName, String filePath);

  Future<Either<Failure, List<FileEntities>>> getFile(String folderName);

  Future<List<String>> downloadUrlFile(List<Reference> refs);
}
