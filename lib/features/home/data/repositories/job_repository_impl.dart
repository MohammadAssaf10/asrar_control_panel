import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/entities/job_entitiies.dart';
import '../../domain/repositories/job_repository.dart';

class JobRepositoryImpl extends JobRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Future<int> getLastJobId() async {
     int id = 0;
    final data = await db.collection(FireBaseCollection.jobs).get();
    if (data.size > 0) {
      for (var doc in data.docs) {
        if (doc["jobId"] > id) {
          id = doc["jobId"];
        }
      }
    }
    return id;
  }

  @override
  Future<Either<Failure, Unit>> addJob(
    JobEntities job,
    String jobImageUrl,
  ) async {
    try {
      final int lastJobId = await getLastJobId()+1;
      final Map<String, dynamic> jobEntities = JobEntities(
        jobId: lastJobId,
        timestamp: job.timestamp,
        jobTitle: job.jobTitle,
        jobDetails: job.jobDetails,
        jobImageName: job.jobImageName,
        jobImageUrl: jobImageUrl,
      ).toMap();
      await db
          .collection(FireBaseCollection.jobs)
          .doc(lastJobId.toString())
          .set(jobEntities);
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteJob(JobEntities job) async {
    try {
      await FirebaseStorage.instance
          .ref("${FireBaseCollection.jobs}/${job.jobImageName}")
          .delete();
      await db
          .collection(FireBaseCollection.jobs)
          .doc(job.jobId.toString())
          .delete();
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<JobEntities>>> getJobsList() async {
    try {
      List<JobEntities> jobsList = [];
      final jobs = await db.collection(FireBaseCollection.jobs).get();
      for (var doc in jobs.docs) {
        jobsList.add(JobEntities.fromMap(doc.data()));
      }
      jobsList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      return Right(jobsList);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
