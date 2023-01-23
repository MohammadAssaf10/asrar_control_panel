import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../../../employees_manager/domain/entities/employee.dart';
import '../../data/models/requests.dart';

abstract class Repository {
  Future<Either<Failure, Employee>> login(LoginRequest loginRequest);
}
