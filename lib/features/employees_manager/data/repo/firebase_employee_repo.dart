import 'package:dartz/dartz.dart';

import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/employees_repo.dart';
import '../../domain/entities/employee.dart';
import '../data_source/firebase_employee_helper.dart';

class FireBaseEmployeeRepo implements EmployeeRepository {
  final FireBaseEmployeeHelper _fireBaseEmployeeHelper =
      FireBaseEmployeeHelper();

  @override
  Future<Either<Failure, List<Employee>>> getEmployeesList() async {
    try {
      final t = await _fireBaseEmployeeHelper.fetchEmployeeList();
      return Right(t);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> updateEmployee(Employee employee) async {
    try {
      await _fireBaseEmployeeHelper.updateEmployee(employee);
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
