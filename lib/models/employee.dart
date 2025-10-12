class EmployeeDTO {
  String employeeName;
  String gender;
  String phone;
  String email;
  int position;

  EmployeeDTO({
    required this.employeeName,
    required this.gender,
    required this.phone,
    required this.email,
    required this.position,
  });

  // 转 JSON 用于 POST
  Map<String, dynamic> toJson() => {
        'employeeName': employeeName,
        'gender': gender,
        'phone': phone,
        'email': email,
        'position': position,
      };
}
