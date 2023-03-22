import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'employee_entitlements_event.dart';
part 'employee_entitlements_state.dart';

class EmployeeEntitlementsBloc extends Bloc<EmployeeEntitlementsEvent, EmployeeEntitlementsState> {
  EmployeeEntitlementsBloc() : super(EmployeeEntitlementsInitial()) {
    on<EmployeeEntitlementsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
