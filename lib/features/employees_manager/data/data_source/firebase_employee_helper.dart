import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/app/functions.dart';
import '../../domain/entities/employee.dart';
import '../../domain/entities/employees_request.dart';

const String employeeCollectionPath = 'Employees';
const String employeesRequestsPath = "employeesUpdateRequests";
const String profileImagesEmployeesFolder = "profileImagesEmployees";

class FireBaseEmployeeHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Employee>> fetchEmployeeList() async {
    List<Employee> employeeList = [];

    final snapshot = await _firestore.collection(employeeCollectionPath).get();

    for (var employee in snapshot.docs) {
      print(employee.data());
      employeeList.add(Employee.fromMap(employee.data()));
    }

    return employeeList;
  }

  Future<void> updateEmployee(Employee employee) async {
    await _firestore
        .collection(employeeCollectionPath)
        .doc(employee.email)
        .set(employee.toMap());
  }

  Future<List<String>> getEmployeeTokenList() async {
    List<String> employeeTokenList = [];
    final employeesDoc =
        await _firestore.collection(employeeCollectionPath).get();
    for (var employee in employeesDoc.docs) {
      for (String employeeToken in employee['employeeTokenList']) {
        employeeTokenList.add(employeeToken);
      }
    }
    return employeeTokenList;
  }

  Future<List<EmployeeRequest>> getEmployeesRequests() async {
    final List<EmployeeRequest> employeesRequestsList = [];
    final employeesRequestsDoc =
        await _firestore.collection(employeesRequestsPath).get();
    for (var employeeRequest in employeesRequestsDoc.docs) {
      employeesRequestsList
          .add(EmployeeRequest.fromMap(employeeRequest.data()));
    }
    employeesRequestsList.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));

    return employeesRequestsList;
  }

  Future<void> acceptEmployeeRequest(EmployeeRequest employeeRequest) async {
    final employeeDoc = _firestore
        .collection(employeeCollectionPath)
        .doc(employeeRequest.employeeID);
    if (employeeRequest.newName.isNotEmpty) {
      await employeeDoc.update({'name': employeeRequest.newName});
    }
    if (employeeRequest.newPhoneNumber.isNotEmpty) {
      await employeeDoc.update({'phoneNumber': employeeRequest.newPhoneNumber});
    }
    if (employeeRequest.newImageName.isNotEmpty) {
      await employeeDoc.update({'imageName': employeeRequest.newImageName});
    }
    if (employeeRequest.newImageURL.isNotEmpty) {
      await employeeDoc.update({'imageURL': employeeRequest.newImageURL});
    }
    if (employeeRequest.oldImageName.isNotEmpty) {
      final String path =
          '$profileImagesEmployeesFolder/${employeeRequest.employeeID}/${employeeRequest.oldImageName}';
      await deleteFile(path);
    }
    await _firestore
        .collection(employeesRequestsPath)
        .doc(employeeRequest.employeeID)
        .delete();
  }

  Future<void> cancelEmployeeRequest(
      String employeeID, String newImageName) async {
    if (newImageName.isNotEmpty) {
      final String path =
          '$profileImagesEmployeesFolder/$employeeID/$newImageName';
      await deleteFile(path);
    }
    await _firestore.collection(employeesRequestsPath).doc(employeeID).delete();
  }
}
