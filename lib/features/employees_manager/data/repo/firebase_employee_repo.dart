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
  Future<Either<Failure, void>> acceptNewEmployee() async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Employee>>> getList() async {
    try {
      return Right(await _fireBaseEmployeeHelper.fetchEmployeeList());
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> rejectEmployee() {
    throw UnimplementedError();
  }
}
