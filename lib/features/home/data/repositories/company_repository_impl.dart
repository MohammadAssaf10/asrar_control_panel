import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/entities/company.dart';
import '../../domain/repositories/company_repository.dart';

class CompanyRepositoryImpl extends CompanyRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<Either<Failure, Unit>> addCompany(
      String folderName, String companyName, String docName) async {
    try {
      final Reference storageRef = FirebaseStorage.instance.ref();
      String url =
          await storageRef.child("$folderName/$companyName").getDownloadURL();
      Map<String, dynamic> companyEntities =
          CompanyEntities(name: companyName, image: url).toMap();
      await db.collection(folderName).doc(docName).set(companyEntities);
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
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
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCompany(String companyName) async {
    try {
      final String c = companyName.substring(0, companyName.length - 4);
      final DocumentReference companystore = db.collection("company").doc(c);
      await companystore.delete();
      final Reference storageRef = FirebaseStorage.instance.ref();
      final companyStorage = storageRef.child("company/$companyName");
      await companyStorage.delete();
      final services = await db.collection("service").get();
      for (var service in services.docs) {
        if (service["companyName"] == c) {
          final serviceDoc = db.collection("service").doc(service.id);
          await serviceDoc.delete();
        }
      }
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
