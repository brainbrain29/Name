import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/employee.dart';

class EmployeeService {
  static const String baseUrl = 'http://localhost:8080/employees'; // Spring Boot 后端地址

  // 添加员工
  static Future<EmployeeDTO?> createEmployee(EmployeeDTO employee) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(employee.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return EmployeeDTO(
        employeeName: data['employeeName'],
        gender: data['gender'],
        phone: data['phone'],
        email: data['email'],
        position: data['position'],
      );
    } else {
      // 可以抛异常或者返回 null
      print('Failed to create employee: ${response.body}');
      return null;
    }
  }
}
