import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/data/failure.dart';
import '../../../../core/data/firebase_exception_handler.dart';
import '../../domain/entities/company.dart';
import '../../domain/repositories/company_repository.dart';

class CompanyRepositoryImpl extends CompanyRepository {
  final FirebaseFirestore db;

  CompanyRepositoryImpl({required this.db});

  @override
  Future<Either<Failure, Unit>> addCompany(
      String folderName, String fileName, String docName) async {
    try {
      final Reference storageRef = FirebaseStorage.instance.ref();
      String url =
          await storageRef.child("$folderName/$fileName").getDownloadURL();
      Map<String, dynamic> companyEntities =
          CompanyEntities(name: docName, image: url).toMap();
      db.collection(folderName).doc(docName).set(companyEntities);
      return const Right(unit);
    } catch (e) {
      return Left(FirebaseExceptionHandler.handle(e).getFailure());
    }
  }

  @override
  Future<Either<Failure, List<CompanyEntities>>> getCompany() async {
    try {
      List<CompanyEntities> company = [];
      final data = await db.collection("company").get();
      for (var doc in data.docs) {
        final CompanyEntities companyEntities =
            CompanyEntities(name: doc["name"], image: doc["image"]);
        company.add(companyEntities);
      }
      return Right(company);
    } catch (e) {
      return Left(FirebaseExceptionHandler.handle(e).getFailure());
    }
  }
}
