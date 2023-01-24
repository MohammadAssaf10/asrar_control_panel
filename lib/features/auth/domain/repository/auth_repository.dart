import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../../../employees_manager/domain/entities/employee.dart';
import '../../data/models/requests.dart';

abstract class AuthRepository {
  Future<Either<Failure, Employee>> login(LoginRequest loginRequest);
  Future<Either<Failure, Employee?>> getCurrentUserIfExists();
  Future<Either<Failure, void>> logout();
}
