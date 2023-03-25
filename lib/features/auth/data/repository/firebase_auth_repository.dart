import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../employees_manager/domain/entities/employee.dart';
import '../../../employees_manager/domain/entities/permissions.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_sources/firebase_auth_helper.dart';
import '../models/requests.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuthHelper _authHelper = FirebaseAuthHelper();

  FirebaseAuthRepository();

  @override
  Future<Either<Failure, Employee>> login(LoginRequest loginRequest) async {
    // is the super admin
    if (loginRequest.email == "asrar@superadmin.com" && loginRequest.password == "123456") {
      return Right(Employee(
          employeeID: '',
          name: 'super admin',
          email: 'asrar@superadmin.com',
          phoneNumber: '',
          idNumber: '',
          national: '',
          permissions: Permissions.superAdmin(),
          employeeTokenList: [],
          employeeID: '',
          imageName: '',
          imageURL: '',
        ),
      );
    }

    // normal admin
    try {
      return Right(await _authHelper.login(loginRequest));
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Employee?>> getCurrentUserIfExists() async {
    try {
      User? user = _authHelper.getCurrentUser();

      if (user == null || user.email == null) return const Right(null);

      Employee employee = await _authHelper.getEmployee(user.email!);

      return Right(employee);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _authHelper.logout();

      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
