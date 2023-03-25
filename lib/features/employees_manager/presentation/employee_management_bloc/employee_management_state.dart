part of 'employee_management_bloc.dart';

enum Status { init, loading, failed, success, cancel }

class EmployeeManagementState extends Equatable {
  // enum
  final Status employeeListStatus;
  final List<Employee> employeeList;

  //enum
  final Status employeeImageStatus;
  final List<FileEntities> employeeImages;

  //enum
  final Status employeeRequestStatus;
  final List<EmployeeRequest> employeesRequestsList;
  final String errorMessage;

  final Status updateEmployeeStatus;

  const EmployeeManagementState({
    required this.employeeListStatus,
    required this.employeeList,
    required this.employeeImageStatus,
    required this.employeeImages,
    required this.updateEmployeeStatus,
    required this.employeesRequestsList,
    required this.employeeRequestStatus,
    required this.errorMessage,
  });

  EmployeeManagementState.empty()
      : employeeListStatus = Status.init,
        employeeList = [],
        employeeImageStatus = Status.init,
        employeeImages = [],
        updateEmployeeStatus = Status.init,
        employeesRequestsList = [],
        employeeRequestStatus = Status.init,
        errorMessage = '';

  EmployeeManagementState copyWith({
    Status? employeeListStatus,
    List<Employee>? employeeList,
    Status? employeeImageStatus,
    List<FileEntities>? employeeImages,
    Status? updateEmployeeStatus,
    List<EmployeeRequest>? employeesRequestsList,
    Status? employeeRequestStatus,
    String? errorMessage,
  }) {
    return EmployeeManagementState(
      employeeListStatus: employeeListStatus ?? this.employeeListStatus,
      employeeList: employeeList ?? this.employeeList,
      employeeImageStatus: employeeImageStatus ?? this.employeeImageStatus,
      employeeImages: employeeImages ?? this.employeeImages,
      updateEmployeeStatus: updateEmployeeStatus ?? this.updateEmployeeStatus,
      employeesRequestsList:
          employeesRequestsList ?? this.employeesRequestsList,
      employeeRequestStatus:
          employeeRequestStatus ?? this.employeeRequestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'EmployeeListState(employeeListStatus: $employeeListStatus, employeeList: $employeeList, employeeImageStatus: $employeeImageStatus, employeeImages: $employeeImages, employeesRequestsList: $employeesRequestsList, employeeRequestStatus: $employeeRequestStatus, errorMessage: $errorMessage)';
  }

  @override
  List<Object> get props => [
        employeeListStatus,
        employeeList,
        employeeImageStatus,
        employeeImages,
        updateEmployeeStatus,
        employeesRequestsList,
        employeeRequestStatus,
        errorMessage,
      ];
}
