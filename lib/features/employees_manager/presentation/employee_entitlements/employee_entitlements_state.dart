part of 'employee_entitlements_bloc.dart';

abstract class EmployeeEntitlementsState extends Equatable {
  const EmployeeEntitlementsState();
  
  @override
  List<Object> get props => [];
}

class EmployeeEntitlementsInitial extends EmployeeEntitlementsState {}
