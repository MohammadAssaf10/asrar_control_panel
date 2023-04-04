import 'package:shared_preferences/shared_preferences.dart';

import '../../../employees_manager/domain/entities/permissions.dart';

const String kIsUserLoggedInKey = "is user logged in";
const String kCanWork = "kCanWork";
const String kAddsManagement = "kAddsManagement";
const String kCompanyManagement = "kCompanyManagement";
const String kCoursesManagement = "kCoursesManagement";
const String kEmployeeManagement = "kEmployeeManagement";
const String kNewsManagement = "kNewsManagement";
const String kStoreManagement = "kStoreManagement";
const String kOffersManagement = "kOffersManagement";
const String kIsRejected = "kIsRejected";
const String kTechnicalSupport = "kTechnicalSupport";

class AuthPreferences {
  final SharedPreferences _sharedPreferences;

  AuthPreferences(this._sharedPreferences);

  Future<void> setPermission(Permissions permissions) async {
    await _sharedPreferences.setBool(kCanWork, permissions.canWork);
    await _sharedPreferences.setBool(
        kAddsManagement, permissions.addsManagement);
    await _sharedPreferences.setBool(
        kCompanyManagement, permissions.companyManagement);
    await _sharedPreferences.setBool(
        kCoursesManagement, permissions.coursesManagement);
    await _sharedPreferences.setBool(
        kEmployeeManagement, permissions.employeeManagement);
    await _sharedPreferences.setBool(
        kNewsManagement, permissions.newsManagement);
    await _sharedPreferences.setBool(kIsRejected, permissions.isRejected);
    await _sharedPreferences.setBool(
        kOffersManagement, permissions.offersManagement);
    await _sharedPreferences.setBool(
        kStoreManagement, permissions.storeManagement);
    await _sharedPreferences.setBool(
        kTechnicalSupport, permissions.technicalSupport);
  }

  bool canWork() {
    return _sharedPreferences.getBool(kCanWork) ?? false;
  }

  bool addsManagement() {
    return (_sharedPreferences.getBool(kAddsManagement) ?? false) &&
        canWork() &&
        !isRejected();
  }

  void setUserLoggedIn() {
    _sharedPreferences.setBool(kIsUserLoggedInKey, true);
  }

  void setUserLoggedOut() {
    _sharedPreferences.setBool(kIsUserLoggedInKey, false);
  }

  bool userLoggedIn() {
    return (_sharedPreferences.getBool(kIsUserLoggedInKey) ?? false);
  }

  bool storeManagement() {
    return (_sharedPreferences.getBool(kStoreManagement) ?? false) &&
        canWork() &&
        !isRejected();
  }

  bool companyManagement() {
    return (_sharedPreferences.getBool(kCompanyManagement) ?? false) &&
        canWork() &&
        !isRejected();
  }

  bool coursesManagement() {
    return (_sharedPreferences.getBool(kCoursesManagement) ?? false) &&
        canWork() &&
        !isRejected();
  }

  bool employeeManagement() {
    return (_sharedPreferences.getBool(kEmployeeManagement) ?? false) &&
        canWork() &&
        !isRejected();
  }

  bool newsManagement() {
    return (_sharedPreferences.getBool(kNewsManagement) ?? false) && canWork();
  }

  bool isRejected() {
    return _sharedPreferences.getBool(kIsRejected) ?? false;
  }

  bool offersManagement() {
    return (_sharedPreferences.getBool(kOffersManagement) ?? false) &&
        canWork() &&
        !isRejected();
  }

  bool technicalSupport() {
    return (_sharedPreferences.getBool(kTechnicalSupport) ?? false) &&
        canWork() &&
        !isRejected();
  }
}
