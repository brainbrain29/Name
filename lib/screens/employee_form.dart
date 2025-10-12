import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/employee_service.dart';

class EmployeeForm extends StatefulWidget {
  const EmployeeForm({super.key});

  @override
  EmployeeFormState createState() => EmployeeFormState();
}

class EmployeeFormState extends State<EmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  // 下拉选择变量
  String? selectedGender;
  int? selectedPosition;

  // 性别选项
  final List<String> genders = ['男性', '女性', '暂时不知道'];
  // 职位选项
  final Map<int, String> positions = {
    1: '部门员工',
    2: '部门领导',
    3: '公司创始人'
  };

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Employee')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? '请输入姓名' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
  decoration: const InputDecoration(labelText: 'Gender'),
  initialValue: selectedGender, // ✅ 替换 value
  items: genders
      .map((g) => DropdownMenuItem(
            value: g,
            child: Text(g),
          ))
      .toList(),
  onChanged: (value) => setState(() => selectedGender = value),
  validator: (value) => value == null ? '请选择性别' : null,
),
              const SizedBox(height: 12),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (value) =>
                    value == null || value.isEmpty ? '请输入电话' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value == null || value.isEmpty ? '请输入邮箱' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
  decoration: const InputDecoration(labelText: 'Position'),
  initialValue: selectedPosition, // ✅ 替换 value
  items: positions.entries
      .map((entry) => DropdownMenuItem(
            value: entry.key,
            child: Text(entry.value),
          ))
      .toList(),
  onChanged: (value) => setState(() => selectedPosition = value),
  validator: (value) => value == null ? '请选择职位' : null,
)
,
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  // 构建 DTO
                  EmployeeDTO dto = EmployeeDTO(
                    employeeName: nameController.text,
                    gender: selectedGender!,
                    phone: phoneController.text,
                    email: emailController.text,
                    position: selectedPosition!,
                  );

                  try {
                    var result = await EmployeeService.createEmployee(dto);

                    if (!mounted) return;

                    if (result != null) {
                      showSnack('Employee created: ${result.employeeName}');
                      // 可选：清空表单
                      _formKey.currentState!.reset();
                      setState(() {
                        selectedGender = null;
                        selectedPosition = null;
                      });
                    }
                  } catch (e) {
                    showSnack('创建失败: $e');
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
