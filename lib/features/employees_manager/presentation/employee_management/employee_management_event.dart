part of 'employee_management_bloc.dart';

abstract class EmployeeManagementEvent extends Equatable {
  const EmployeeManagementEvent();

  @override
  List<Object> get props => [];
}

class FetchEmployeesList extends EmployeeManagementEvent {}

class FetchEmployeeImages extends EmployeeManagementEvent {
  final Employee employee;

  const FetchEmployeeImages({
    required this.employee,
  });

  @override
  List<Object> get props => [employee];
}

class UpdateEmployee extends EmployeeManagementEvent {
  final Employee employee;

  const UpdateEmployee({
    required this.employee,
  });

  @override
  List<Object> get props => [employee];
}
