import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/app/di.dart';
import '../../../employees_manager/domain/entities/employee.dart';
import '../models/requests.dart';
import 'auth_prefs.dart';

const String employeeCollectionPath = 'Employees';

class FirebaseAuthHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthPreferences authPreferences=instance<AuthPreferences>();

  Future<Employee> login(LoginRequest loginRequest) async {

    final employee = (await _firebaseAuth.signInWithEmailAndPassword(
        email: loginRequest.email, password: loginRequest.password))
        .user;
    authPreferences.setUserLoggedIn();
    return await getEmployee(employee!.uid);
  }

  Future<Employee> getEmployee(String id) async {
    final employeeMap =
        (await _firestore.collection(employeeCollectionPath).doc(id).get())
            .data();

    if (employeeMap == null) {
      throw FirebaseAuthException(code: "auth/user-not-found");
    }

    return Employee.fromMap(employeeMap);
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    authPreferences.setUserLoggedOut();
  }
}
