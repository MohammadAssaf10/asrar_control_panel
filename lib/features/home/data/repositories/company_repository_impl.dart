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
      final int lastCompanyRanking = await getLastCompanyRanking() + 1;
      Map<String, dynamic> companyEntities = CompanyEntities(
        companyRanking: lastCompanyRanking,
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
          companyRanking: doc["companyRanking"],
          fullName: doc["fullName"],
          name: doc["name"],
          image: doc["image"],
        );
        company.add(companyEntities);
      }
      company.sort((a, b) => a.companyRanking.compareTo(b.companyRanking));
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

  @override
  Future<int> getLastCompanyRanking() async {
    int lastRanking = 0;
    final data = await db.collection(FireBaseCollection.companies).get();
    if (data.size > 0) {
      for (var doc in data.docs) {
        if (doc["companyRanking"] > lastRanking) {
          lastRanking = doc["companyRanking"];
        }
      }
    }
    return lastRanking;
  }

  @override
  Future<Either<Failure, Unit>> updateCompanyRanking(
      String companyName, int newRanking, int oldRanking) async {
    try {
      final data = await db.collection(FireBaseCollection.companies).get();
      for (var doc in data.docs) {
        if (doc["companyRanking"] == newRanking) {
          await db
          .collection(FireBaseCollection.companies)
          .doc(doc["name"])
          .update({"companyRanking": oldRanking});
        }
      }
      await db
          .collection(FireBaseCollection.companies)
          .doc(companyName)
          .update({"companyRanking": newRanking});
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
