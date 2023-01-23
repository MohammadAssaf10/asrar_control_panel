part of 'employee_list_bloc.dart';

enum Status { init, loading, failed, success }

class EmployeeListState extends Equatable {
  // enum
  final Status employeeListStatus;
  final List<Employee> employeeList;
  //enum
  final Status employeeImageStatus;
  final List<FileEntities> employeeImages;

  final Status updateEmployeeStatus;

  const EmployeeListState({
    required this.employeeListStatus,
    required this.employeeList,
    required this.employeeImageStatus,
    required this.employeeImages,
    required this.updateEmployeeStatus
  });

  EmployeeListState.empty()
      : employeeListStatus = Status.init,
        employeeList = [],
        employeeImageStatus = Status.init,
        employeeImages = [],
        updateEmployeeStatus = Status.init;

  EmployeeListState copyWith({
    Status? employeeListStatus,
    List<Employee>? employeeList,
    Status? employeeImageStatus,
    List<FileEntities>? employeeImages,
    Status? updateEmployeeStatus
  }) {
    return EmployeeListState(
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
  List<Object> get props =>
      [employeeListStatus, employeeList, employeeImageStatus, employeeImages, updateEmployeeStatus];
}
