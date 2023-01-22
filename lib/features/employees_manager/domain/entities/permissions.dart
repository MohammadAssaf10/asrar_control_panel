import 'dart:convert';

class Permissions {
  bool canWork;
  bool employeeManagement;
  bool newsManagement;
  bool addsManagement;
  bool offersManagement;
  bool companyManagement;
  bool coursesManagement;
  bool technicalSupport;
  Permissions({
    required this.canWork,
    required this.employeeManagement,
    required this.newsManagement,
    required this.addsManagement,
    required this.offersManagement,
    required this.companyManagement,
    required this.coursesManagement,
    required this.technicalSupport,
  });

  Permissions copyWith({
    bool? canWork,
    bool? employeeManagement,
    bool? newsManagement,
    bool? addsManagement,
    bool? offersManagement,
    bool? companyManagement,
    bool? coursesManagement,
    bool? technicalSupport,
  }) {
    return Permissions(
      canWork: canWork ?? this.canWork,
      employeeManagement: employeeManagement ?? this.employeeManagement,
      newsManagement: newsManagement ?? this.newsManagement,
      addsManagement: addsManagement ?? this.addsManagement,
      offersManagement: offersManagement ?? this.offersManagement,
      companyManagement: companyManagement ?? this.companyManagement,
      coursesManagement: coursesManagement ?? this.coursesManagement,
      technicalSupport: technicalSupport ?? this.technicalSupport,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'canWork': canWork});
    result.addAll({'employeeManagement': employeeManagement});
    result.addAll({'newsManagement': newsManagement});
    result.addAll({'addsManagement': addsManagement});
    result.addAll({'offersManagement': offersManagement});
    result.addAll({'companyManagement': companyManagement});
    result.addAll({'coursesManagement': coursesManagement});
    result.addAll({'technicalSupport': technicalSupport});
  
    return result;
  }

  factory Permissions.fromMap(Map<String, dynamic> map) {
    return Permissions(
      canWork: map['canWork'] ?? false,
      employeeManagement: map['employeeManagement'] ?? false,
      newsManagement: map['newsManagement'] ?? false,
      addsManagement: map['addsManagement'] ?? false,
      offersManagement: map['offersManagement'] ?? false,
      companyManagement: map['companyManagement'] ?? false,
      coursesManagement: map['coursesManagement'] ?? false,
      technicalSupport: map['technicalSupport'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Permissions.fromJson(String source) => Permissions.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Permissions(canWork: $canWork, employeeManagement: $employeeManagement, newsManagement: $newsManagement, addsManagement: $addsManagement, offersManagement: $offersManagement, companyManagement: $companyManagement, coursesManagement: $coursesManagement, technicalSupport: $technicalSupport)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Permissions &&
      other.canWork == canWork &&
      other.employeeManagement == employeeManagement &&
      other.newsManagement == newsManagement &&
      other.addsManagement == addsManagement &&
      other.offersManagement == offersManagement &&
      other.companyManagement == companyManagement &&
      other.coursesManagement == coursesManagement &&
      other.technicalSupport == technicalSupport;
  }

  @override
  int get hashCode {
    return canWork.hashCode ^
      employeeManagement.hashCode ^
      newsManagement.hashCode ^
      addsManagement.hashCode ^
      offersManagement.hashCode ^
      companyManagement.hashCode ^
      coursesManagement.hashCode ^
      technicalSupport.hashCode;
  }
}
