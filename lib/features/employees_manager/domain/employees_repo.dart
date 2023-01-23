import 'package:dartz/dartz.dart';

import '../../../core/data/failure.dart';
import 'entities/employee.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, List<Employee>>> getEmployeesList();
  Future<Either<Failure, void>> updateEmployee(Employee employee);
}
