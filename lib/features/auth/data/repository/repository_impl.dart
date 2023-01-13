import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repository/repository.dart';
import '../models/requests.dart';

class RepositoryImp implements Repository {
  RepositoryImp();

  @override
  Future<Either<Failure, User>> login(LoginRequest loginRequest) async {
    User user = User(name: 'admin', email: '');

    if (loginRequest.email == "asrar@admin.com" &&
        loginRequest.password == "123456") {
      user.copyWith(email: loginRequest.email);
    } else {
      return Left(Failure(404, 'incorrect email or password'));
    }

    return Right(user);
  }
}
