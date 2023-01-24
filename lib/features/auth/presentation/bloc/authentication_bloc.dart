import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/app/di.dart' as di;
import '../../../employees_manager/domain/entities/employee.dart';
import '../../data/data_sources/auth_prefs.dart';
import '../../data/models/requests.dart';
import '../../domain/repository/auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authRepository = di.instance<AuthRepository>();
  final AuthPreferences _authPreferences = di.instance<AuthPreferences>();

  

  static AuthenticationBloc instance = AuthenticationBloc._();

  AuthenticationBloc._() : super(AuthenticationInitial()) {
    // login
    on<LoginButtonPressed>((event, emit) async {
      emit(AuthenticationInProgress());

      (await _authRepository.login(event.loginRequest)).fold(
        (failure) {
          emit(AuthenticationFailed(failure.message));
        },
        (employee) async {
          emit(AuthenticationSuccess(employee: employee));
          await _authPreferences.setPermission(employee.permissions);
        },
      );
    });

    on<AppStarted>((event, emit) async {
      (await _authRepository.getCurrentUserIfExists()).fold(((l) {}),
          ((employee) async {
        if (employee != null) {
          emit(AuthenticationSuccess(employee: employee));
          await _authPreferences.setPermission(employee.permissions);
        }
      }));
    });

    on<LogOut>((event, emit) async {
      await _authRepository.logout();

      emit(AuthenticationInitial());
    });
  }
}
