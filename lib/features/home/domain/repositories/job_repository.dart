import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/job_entitiies.dart';

abstract class JobRepository {
  Future<Either<Failure, Unit>> addJob(
    JobEntities job,
    String jobImageUrl,
  );
  Future<Either<Failure, List<JobEntities>>> getJobsList();
  Future<Either<Failure, Unit>> deleteJob(
    JobEntities job,
  );
}
