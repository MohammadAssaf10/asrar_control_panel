import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../employees_manager/domain/entities/employee.dart';
import '../models/requests.dart';



const String employeeCollectionPath = 'Employees';

class FirebaseAuthHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Employee> login(LoginRequest loginRequest) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: loginRequest.email, password: loginRequest.password);

    final employeeMap = (await _firestore
            .collection(employeeCollectionPath)
            .doc(loginRequest.email)
            .get())
        .data();

    if (employeeMap == null) {
      throw FirebaseAuthException(code: "auth/user-not-found");
    }

    return Employee.fromMap(employeeMap);
  }

  Future<Employee> getEmployee(Employee employee)async {

    final employeeMap = (await _firestore
            .collection(employeeCollectionPath)
            .doc(employee.email)
            .get())
        .data();

    if (employeeMap == null) {
      throw FirebaseAuthException(code: "auth/user-not-found");
    }

    return Employee.fromMap(employeeMap);
  }
}
