import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/entities/company.dart';
import '../../domain/repositories/company_repository.dart';

class CompanyRepositoryImpl extends CompanyRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<Either<Failure, Unit>> addCompany(
      String companyFullName, String docName) async {
    try {
      final Reference storageRef = FirebaseStorage.instance.ref();
      String url = await storageRef
          .child("${FireBaseCollection.companies}/$companyFullName")
          .getDownloadURL();
      Map<String, dynamic> companyEntities = CompanyEntities(
        fullName: companyFullName,
        name: docName,
        image: url,
      ).toMap();
      await db
          .collection(FireBaseCollection.companies)
          .doc(docName)
          .set(companyEntities);
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<CompanyEntities>>> getCompany() async {
    try {
      List<CompanyEntities> company = [];
      final data = await db.collection(FireBaseCollection.companies).get();
      for (var doc in data.docs) {
        final CompanyEntities companyEntities = CompanyEntities(
            fullName: doc["fullName"], name: doc["name"], image: doc["image"]);
        company.add(companyEntities);
      }
      return Right(company);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  // companyFullName: Name with subsequent(.jpg or .png)
  // companyName: Just name without subsequent
  @override
  Future<Either<Failure, Unit>> deleteCompany(
      String companyFullName, String companyName) async {
    try {
      final DocumentReference companystore =
          db.collection(FireBaseCollection.companies).doc(companyName);
      await companystore.delete();
      final Reference storageRef = FirebaseStorage.instance.ref();
      final companyStorage =
          storageRef.child("${FireBaseCollection.companies}/$companyFullName");
      await companyStorage.delete();
      final services = await db.collection(FireBaseCollection.services).get();
      for (var service in services.docs) {
        if (service["companyName"] == companyName) {
          final serviceDoc =
              db.collection(FireBaseCollection.services).doc(service.id);
          await serviceDoc.delete();
        }
      }
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
