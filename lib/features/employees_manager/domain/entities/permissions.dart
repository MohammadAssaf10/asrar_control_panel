import 'dart:convert';

/// steps to add new filed to this class
/// * regenerate data class
/// * add the field to the superAdmin constructor as true
/// * in [auth_prefs.dart] file add to [AuthPreferences] in [setPermission] and create a new method for retrieve it
/// * in [permission_list.dart] file add new [PermissionCheckbox] to handel this new permission
/// all done no need to edit any thing else
class Permissions {
  bool isRejected;
  bool canWork;
  bool employeeManagement;
  bool newsManagement;
  bool addsManagement;
  bool offersManagement;
  bool companyManagement;
  bool coursesManagement;
  bool storeManagement;
  bool technicalSupport;

  Permissions.superAdmin()
      : isRejected = false,
        canWork = true,
        employeeManagement = true,
        newsManagement = true,
        addsManagement = true,
        offersManagement = true,
        companyManagement = true,
        coursesManagement = true,
        storeManagement = true,
        technicalSupport = true;

  Permissions({
    required this.isRejected,
    required this.canWork,
    required this.employeeManagement,
    required this.newsManagement,
    required this.addsManagement,
    required this.offersManagement,
    required this.companyManagement,
    required this.coursesManagement,
    required this.storeManagement,
    required this.technicalSupport,
  });

  Permissions copyWith({
    bool? isRejected,
    bool? canWork,
    bool? employeeManagement,
    bool? newsManagement,
    bool? addsManagement,
    bool? offersManagement,
    bool? companyManagement,
    bool? coursesManagement,
    bool? storeManagement,
    bool? technicalSupport,
  }) {
    return Permissions(
      isRejected: isRejected ?? this.isRejected,
      canWork: canWork ?? this.canWork,
      employeeManagement: employeeManagement ?? this.employeeManagement,
      newsManagement: newsManagement ?? this.newsManagement,
      addsManagement: addsManagement ?? this.addsManagement,
      offersManagement: offersManagement ?? this.offersManagement,
      companyManagement: companyManagement ?? this.companyManagement,
      coursesManagement: coursesManagement ?? this.coursesManagement,
      storeManagement: storeManagement ?? this.storeManagement,
      technicalSupport: technicalSupport ?? this.technicalSupport,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'isRejected': isRejected});
    result.addAll({'canWork': canWork});
    result.addAll({'employeeManagement': employeeManagement});
    result.addAll({'newsManagement': newsManagement});
    result.addAll({'addsManagement': addsManagement});
    result.addAll({'offersManagement': offersManagement});
    result.addAll({'companyManagement': companyManagement});
    result.addAll({'coursesManagement': coursesManagement});
    result.addAll({'storeManagement': storeManagement});
    result.addAll({'technicalSupport': technicalSupport});

    return result;
  }

  factory Permissions.fromMap(Map<String, dynamic> map) {
    return Permissions(
      isRejected: map['isRejected'] ?? false,
      canWork: map['canWork'] ?? false,
      employeeManagement: map['employeeManagement'] ?? false,
      newsManagement: map['newsManagement'] ?? false,
      addsManagement: map['addsManagement'] ?? false,
      offersManagement: map['offersManagement'] ?? false,
      companyManagement: map['companyManagement'] ?? false,
      coursesManagement: map['coursesManagement'] ?? false,
      storeManagement: map['storeManagement'] ?? false,
      technicalSupport: map['technicalSupport'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Permissions.fromJson(String source) =>
      Permissions.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Permissions(isRejected: $isRejected, canWork: $canWork, employeeManagement: $employeeManagement, newsManagement: $newsManagement, addsManagement: $addsManagement, offersManagement: $offersManagement, companyManagement: $companyManagement, coursesManagement: $coursesManagement, storeManagement: $storeManagement, technicalSupport: $technicalSupport)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Permissions &&
        other.isRejected == isRejected &&
        other.canWork == canWork &&
        other.employeeManagement == employeeManagement &&
        other.newsManagement == newsManagement &&
        other.addsManagement == addsManagement &&
        other.offersManagement == offersManagement &&
        other.companyManagement == companyManagement &&
        other.coursesManagement == coursesManagement &&
        other.storeManagement == storeManagement &&
        other.technicalSupport == technicalSupport;
  }

  @override
  int get hashCode {
    return isRejected.hashCode ^
        canWork.hashCode ^
        employeeManagement.hashCode ^
        newsManagement.hashCode ^
        addsManagement.hashCode ^
        offersManagement.hashCode ^
        companyManagement.hashCode ^
        coursesManagement.hashCode ^
        storeManagement.hashCode ^
        technicalSupport.hashCode;
  }
}
