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

class GetEmployeesRequests extends EmployeeManagementEvent {
  @override
  List<Object> get props => [];
}

class AcceptEmployeeRequest extends EmployeeManagementEvent {
  final EmployeeRequest employeeRequest;

  const AcceptEmployeeRequest({required this.employeeRequest});

  @override
  List<Object> get props => [employeeRequest];
}

class CancelEmployeeRequest extends EmployeeManagementEvent {
  final String employeeId;
  final String newImageName;

  const CancelEmployeeRequest({
    required this.employeeId,
    required this.newImageName,
  });

  @override
  List<Object> get props => [employeeId, newImageName];
}
