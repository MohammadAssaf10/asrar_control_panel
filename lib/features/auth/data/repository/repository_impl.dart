
import 'package:dartz/dartz.dart';

import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../employees_manager/domain/entities/employee.dart';
import '../../../employees_manager/domain/entities/permissions.dart';
import '../../domain/repository/repository.dart';
import '../data_sources/firebase_auth_helper.dart';
import '../models/requests.dart';

class RepositoryImp implements Repository {
  final FirebaseAuthHelper _authHelper = FirebaseAuthHelper();

  RepositoryImp();

  @override
  Future<Either<Failure, Employee>> login(LoginRequest loginRequest) async {
    // is the super admin
    if (loginRequest.email == "asrar@superadmin.com" &&
        loginRequest.password == "123456") {
      return Right(Employee(
          name: 'super admin',
          email: 'asrar@superadmin.com',
          phonNumber: '',
          idNumber: '',
          national: '',
          permissions: Permissions(
              isRejected: false,
              canWork: true,
              employeeManagement: true,
              newsManagement: true,
              addsManagement: true,
              offersManagement: true,
              companyManagement: true,
              coursesManagement: true,
              technicalSupport: true)));
    }

    // normal admin
    try {
      return Right(await _authHelper.login(loginRequest));
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
