import 'package:dartz/dartz.dart';

import '../../../core/data/failure.dart';
import 'entities/employee.dart';
import 'entities/employees_request.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, List<Employee>>> getEmployeesList();

  Future<Either<Failure, void>> updateEmployee(Employee employee);

  Future<Either<Failure, List<EmployeeRequest>>> getEmployeesRequests();

  Future<Either<Failure, void>> acceptEmployeeRequest(
      EmployeeRequest employeeRequest);

  Future<Either<Failure, void>> cancelEmployeeRequest(
      String employeeId, String newImageName);
}
