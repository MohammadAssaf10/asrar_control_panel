part of 'employee_list_bloc.dart';

abstract class EmployeeListEvent extends Equatable {
  const EmployeeListEvent();

  @override
  List<Object> get props => [];
}

class FetchEmployeesList extends EmployeeListEvent {}

class FetchEmployeeImages extends EmployeeListEvent {
  final Employee employee;

  const FetchEmployeeImages({
    required this.employee,
  });

  @override
  List<Object> get props => [employee];
}

class UpdateEmployee extends EmployeeListEvent {
  final Employee employee;

  const UpdateEmployee({
    required this.employee,

   
  });

   @override
  List<Object> get props => [employee];
}
