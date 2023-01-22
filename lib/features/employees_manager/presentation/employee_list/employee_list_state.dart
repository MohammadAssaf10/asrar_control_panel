part of 'employee_list_bloc.dart';

enum Status { init, loading, failed, success }

class EmployeeListState extends Equatable {
  // enum
  final Status employeeListStatus;
  final List<Employee> employeeList;
  //enum
  final Status employeeImageStatus;
  final List<FileEntities> employeeImages;

  const EmployeeListState({
    required this.employeeListStatus,
    required this.employeeList,
    required this.employeeImageStatus,
    required this.employeeImages,
  });

  EmployeeListState.empty()
      : employeeListStatus = Status.init,
        employeeList = [],
        employeeImageStatus = Status.init,
        employeeImages = [];

  EmployeeListState copyWith({
    Status? employeeListStatus,
    List<Employee>? employeeList,
    Status? employeeImageStatus,
    List<FileEntities>? employeeImages,
  }) {
    return EmployeeListState(
      employeeListStatus: employeeListStatus ?? this.employeeListStatus,
      employeeList: employeeList ?? this.employeeList,
      employeeImageStatus: employeeImageStatus ?? this.employeeImageStatus,
      employeeImages: employeeImages ?? this.employeeImages,
    );
  }

  @override
  String toString() {
    return 'EmployeeListState(employeeListStatus: $employeeListStatus, employeeList: $employeeList, employeeImageStatus: $employeeImageStatus, employeeImages: $employeeImages)';
  }

  @override
  List<Object> get props =>
      [employeeListStatus, employeeList, employeeImageStatus, employeeImages];
}
