part of 'employee_management_bloc.dart';

enum Status { init, loading, failed, success }

class EmployeeManagementState extends Equatable {
  // enum
  final Status employeeListStatus;
  final List<Employee> employeeList;
  //enum
  final Status employeeImageStatus;
  final List<FileEntities> employeeImages;

  final Status updateEmployeeStatus;

  const EmployeeManagementState(
      {required this.employeeListStatus,
      required this.employeeList,
      required this.employeeImageStatus,
      required this.employeeImages,
      required this.updateEmployeeStatus});

  EmployeeManagementState.empty()
      : employeeListStatus = Status.init,
        employeeList = [],
        employeeImageStatus = Status.init,
        employeeImages = [],
        updateEmployeeStatus = Status.init;

  EmployeeManagementState copyWith(
      {Status? employeeListStatus,
      List<Employee>? employeeList,
      Status? employeeImageStatus,
      List<FileEntities>? employeeImages,
      Status? updateEmployeeStatus}) {
    return EmployeeManagementState(
      employeeListStatus: employeeListStatus ?? this.employeeListStatus,
      employeeList: employeeList ?? this.employeeList,
      employeeImageStatus: employeeImageStatus ?? this.employeeImageStatus,
      employeeImages: employeeImages ?? this.employeeImages,
      updateEmployeeStatus: updateEmployeeStatus ?? this.updateEmployeeStatus,
    );
  }

  @override
  String toString() {
    return 'EmployeeListState(employeeListStatus: $employeeListStatus, employeeList: $employeeList, employeeImageStatus: $employeeImageStatus, employeeImages: $employeeImages)';
  }

  @override
  List<Object> get props => [
        employeeListStatus,
        employeeList,
        employeeImageStatus,
        employeeImages,
        updateEmployeeStatus
      ];
}
