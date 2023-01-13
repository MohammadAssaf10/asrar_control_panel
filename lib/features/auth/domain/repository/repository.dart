import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../../data/models/requests.dart';
import '../entities/entities.dart';

abstract class Repository {
  Future<Either<Failure, User>> login(LoginRequest loginRequest);
}
