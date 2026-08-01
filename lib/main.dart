import 'package:flutter/material.dart';

void main() {
  runApp(const StaffManagerApp());
}

class StaffManagerApp extends StatelessWidget {
  const StaffManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'إدارة الموظفين',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const EmployeeListScreen(),
    );
  }
}

class Employee {
  final String id;
  final String name;
  final String registrationNumber;
  final String workCenter;
  final String role;
  final String restDay;

  Employee({
    required this.id,
    required this.name,
    required this.registrationNumber,
    required this.workCenter,
    required this.role,
    required this.restDay,
  });
}

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final List<Employee> _employees = [];

  void _addEmployee(Employee employee) {
    setState(() {
      _employees.add(employee);
    });
  }

  void _showAddEmployeeDialog() {
    final nameController = TextEditingController();
    final regController = TextEditingController();
    final centerController = TextEditingController();
    final roleController = TextEditingController();
    String selectedRestDay = 'الأحد';

    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('إضافة موظف جديد', textAlign: TextAlign.right),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'الاسم الكامل'),
                ),
                TextField(
                  controller: regController,
                  decoration: const InputDecoration(labelText: 'الرقم الإداري / التسجيلي'),
                ),
                TextField(
                  controller: centerController,
                  decoration: const InputDecoration(labelText: 'مركز العمل / المرفق'),
                ),
                TextField(
                  controller: roleController,
                  decoration: const InputDecoration(labelText: 'المهمة المسندة'),
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: selectedRestDay,
                  decoration: const InputDecoration(labelText: 'يوم الراحة الأسبوعية'),
                  items: ['الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد']
                      .map((day) => DropdownMenuItem(value: day, child: Text(day)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) selectedRestDay = val;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  _addEmployee(
                    Employee(
                      id: DateTime.now().toString(),
                      name: nameController.text,
                      registrationNumber: regController.text,
                      workCenter: centerController.text,
                      role: roleController.text,
                      restDay: selectedRestDay,
                    ),
                  );
                  Navigator.of(ctx).pop();
                }
              },
              child: const Text('إضافة'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('إدارة الموظفين (${_employees.length})'),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: _employees.isEmpty
            ? const Center(
                child: Text(
                  'لا يوجد موظفين حالياً.\nاضغط على الزر لأسفل لإضافة موظف.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: _employees.length,
                itemBuilder: (ctx, index) {
                  final emp = _employees[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(emp.name.isNotEmpty ? emp.name[0] : '?'),
                      ),
                      title: Text(
                        emp.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text('الرقم الإداري: ${emp.registrationNumber}'),
                          Text('المركز: ${emp.workCenter} | المهمة: ${emp.role}'),
                          Text(
                            'الراحة الأسبوعية: ${emp.restDay}',
                            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _showAddEmployeeDialog,
          icon: const Icon(Icons.person_add),
          label: const Text('إضافة موظف'),
        ),
      ),
    );
  }
}
