
import 'package:dartz/dartz.dart';

import '../../../core/data/failure.dart';
import 'entities/employee.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, List<Employee>>> getList();
  Future<Either<Failure, void>> acceptNewEmployee();
  Future<Either<Failure, void>> rejectEmployee();
}
