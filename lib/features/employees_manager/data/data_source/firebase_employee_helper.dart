import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/employee.dart';

const String employeeCollectionPath = 'Employees';

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
}
