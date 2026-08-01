import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const StaffManagementApp());
}

class StaffManagementApp extends StatefulWidget {
  const StaffManagementApp({Key? key}) : super(key: key);

  @override
  State<StaffManagementApp> createState() => _StaffManagementAppState();
}

class _StaffManagementAppState extends State<StaffManagementApp> {
  Locale _locale = const Locale('ar');

  void _toggleLanguage() {
    setState(() {
      _locale = _locale.languageCode == 'ar' ? const Locale('fr') : const Locale('ar');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'إدارة الموظفين',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [
        Locale('ar'),
        Locale('fr'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A),
          primary: const Color(0xFF1E3A8A),
          secondary: const Color(0xFF0D9488),
          surface: const Color(0xFFF8FAFC),
        ),
      ),
      home: EmployeeListScreen(onToggleLanguage: _toggleLanguage, currentLocale: _locale),
    );
  }
}

class Employee {
  String id;
  String name;
  String workCenter;
  List<String> restDays;

  Employee({
    required this.id,
    required this.name,
    required this.workCenter,
    required this.restDays,
  });
}

class EmployeeListScreen extends StatefulWidget {
  final VoidCallback onToggleLanguage;
  final Locale currentLocale;

  const EmployeeListScreen({
    Key? key,
    required this.onToggleLanguage,
    required this.currentLocale,
  }) : super(key: key);

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final List<Employee> _allEmployees = [
    Employee(id: 'EMP-1001', name: 'خلفاوي الحسين', workCenter: 'رئيس المعقل', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1002', name: 'زكرياء الكفيش', workCenter: 'نائب رئيس المعقل', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1003', name: 'البازي عبد الرحيم', workCenter: 'نائب رئيس المعقل', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1004', name: 'عبد الله بشبلا', workCenter: 'نائب رئيس المعقل', restDays: ['الخميس', 'الجمعة']),
    Employee(id: 'EMP-1005', name: 'علي الحراث', workCenter: 'نائب رئيس المعقل', restDays: ['الثلاثاء', 'الأربعاء']),
    Employee(id: 'EMP-1006', name: 'عبد الرحمان وركة', workCenter: 'التصنيف و الإيواء', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1007', name: 'سعيد الهواري', workCenter: 'ضبط سجلات باب المعقل', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1008', name: 'موسى بوري', workCenter: 'التفتيش في باب المعقل', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1009', name: 'خالد أوقاس', workCenter: 'ضبط حركة باب المعقل', restDays: ['الجمعة', 'السبت']),
    Employee(id: 'EMP-1010', name: 'محمد عبيد', workCenter: 'ضبط حركة باب المعقل', restDays: ['الأربعاء', 'الخميس']),
    Employee(id: 'EMP-1011', name: 'نور الدين جباري', workCenter: 'الخفر إلى المستشفى', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1012', name: 'عبد الحق العلمي', workCenter: 'الخفر إلى المستشفى', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1013', name: 'مهدي عزمي', workCenter: 'الخفر إلى المستشفى', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1014', name: 'بلمهدي عز الدين', workCenter: 'الخفر إلى المستشفى', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1015', name: 'خالد الغربة', workCenter: 'رئيس الحي الأول', restDays: ['الأربعاء', 'الخميس']),
    Employee(id: 'EMP-1016', name: 'أحمد أبوزيا', workCenter: 'نائب رئيس الحي الأول', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1017', name: 'حمادي محمد', workCenter: 'الحي الأول الجناح الأول', restDays: ['الاثنين', 'الثلاثاء']),
    Employee(id: 'EMP-1018', name: 'ياسين اعميمي', workCenter: 'الحي الأول الجناح الأول', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1019', name: 'عبد الكريم الحنفي', workCenter: 'الحي الأول الجناح الثاني', restDays: ['الثلاثاء', 'الأربعاء']),
    Employee(id: 'EMP-1020', name: 'محمد حافيضي', workCenter: 'الحي الأول الجناح الثاني', restDays: ['الخميس', 'الجمعة']),
    Employee(id: 'EMP-1021', name: 'خالد عكوري', workCenter: 'الحي الأول الجناح الثالث', restDays: ['الثلاثاء', 'الأربعاء']),
    Employee(id: 'EMP-1022', name: 'التاج محمد', workCenter: 'الحي الأول الجناح الثالث', restDays: ['الخميس', 'الجمعة']),
    Employee(id: 'EMP-1023', name: 'إبراهيم المجدي', workCenter: 'باب الحي الأول', restDays: ['الثلاثاء', 'الأربعاء']),
    Employee(id: 'EMP-1024', name: 'مهدي ادراوي', workCenter: 'فسحة الحي الأول', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1025', name: 'حسن عمري', workCenter: 'رئيس الحي الثاني', restDays: ['الاثنين', 'الثلاثاء']),
    Employee(id: 'EMP-1026', name: 'مهدي بنعشى', workCenter: 'نائب رئيس الحي الثاني', restDays: ['الأربعاء', 'الخميس']),
    Employee(id: 'EMP-1027', name: 'حسن بنخديجة', workCenter: 'الجناح الأول الحي الثاني', restDays: ['الأربعاء', 'الخميس']),
    Employee(id: 'EMP-1028', name: 'إدريس أيت عيسى', workCenter: 'الجناح الأول الحي الثاني', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1029', name: 'هني عبد اللطيف', workCenter: 'الجناح الثاني الحي الثاني', restDays: ['الخميس', 'الجمعة']),
    Employee(id: 'EMP-1030', name: 'ياسين حافيضي', workCenter: 'الجناح الثاني الحي الثاني', restDays: ['الثلاثاء', 'الأربعاء']),
    Employee(id: 'EMP-1031', name: 'عبد العظيم فريد', workCenter: 'الجناح الثاني الحي الثاني', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1032', name: 'عمران اوحميدوش', workCenter: 'فسحة الحي الثاني', restDays: ['الثلاثاء', 'الأربعاء']),
    Employee(id: 'EMP-1033', name: 'وحمان يوسف', workCenter: 'رئيس الحي الثالث', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1034', name: 'محمد الكنطاري', workCenter: 'نائب رئيس الحي الثالث', restDays: ['الأربعاء', 'الخميس']),
    Employee(id: 'EMP-1035', name: 'مصعب بوعلام', workCenter: 'الحي الثالث الجناح الأول', restDays: ['الاثنين', 'الثلاثاء']),
    Employee(id: 'EMP-1036', name: 'عبد الرحمان العوفي', workCenter: 'الحي الثالث الجناح الأول', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1037', name: 'سيف الدين العبار', workCenter: 'الحي الثالث الجناح الثاني', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1038', name: 'وليد كمال', workCenter: 'الحي الثالث الجناح الثاني', restDays: ['الخميس', 'الجمعة']),
    Employee(id: 'EMP-1039', name: 'رضى بنكايس', workCenter: 'الحي الثالث الجناح الثالث', restDays: ['الخميس', 'الجمعة']),
    Employee(id: 'EMP-1040', name: 'يونس حنيكيش', workCenter: 'الحي الثالث الجناح الثالث', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1126', name: 'محمد', workCenter: 'الحراسة في الباب الرسم السامري', restDays: ['السبت', 'الأحد']),
    Employee(id: 'EMP-1127', name: 'أيوب المغيثي', workCenter: 'باب الإيقاف', restDays: ['الاثنين', 'الثلاثاء']),
    Employee(id: 'EMP-1132', name: 'محمد القليعي', workCenter: 'موقوف عن العمل', restDays: []),
    Employee(id: 'EMP-1133', name: 'محمد الصديقي', workCenter: 'التكوين المستمر', restDays: []),
    Employee(id: 'EMP-1134', name: 'عبد الله مساعد', workCenter: 'رخصة مرضية', restDays: []),
  ];

  List<Employee> _filteredEmployees = [];
  String _searchQuery = '';
  String? _selectedDay;
  String? _selectedWorkCenter;

  final List<String> _daysOfWeek = ['السبت', 'الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة'];

  @override
  void initState() {
    super.initState();
    _filteredEmployees = List.from(_allEmployees);
  }

  void _filterData() {
    setState(() {
      _filteredEmployees = _allEmployees.where((emp) {
        final matchesSearch = emp.name.contains(_searchQuery) ||
            emp.id.contains(_searchQuery) ||
            emp.workCenter.contains(_searchQuery);

        final matchesDay = _selectedDay == null || emp.restDays.contains(_selectedDay);
        final matchesCenter = _selectedWorkCenter == null || emp.workCenter == _selectedWorkCenter;

        return matchesSearch && matchesDay && matchesCenter;
      }).toList();
    });
  }

  void _showAddEditDialog({Employee? employee, int? index}) {
    final isAr = widget.currentLocale.languageCode == 'ar';
    final idController = TextEditingController(text: employee?.id ?? '');
    final nameController = TextEditingController(text: employee?.name ?? '');
    final centerController = TextEditingController(text: employee?.workCenter ?? '');
    List<String> selectedRestDays = List.from(employee?.restDays ?? []);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(employee == null ? (isAr ? 'إضافة موظف' : 'Ajouter') : (isAr ? 'تعديل موظف' : 'Modifier')),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: idController,
                      decoration: InputDecoration(labelText: isAr ? 'الرقم الإداري' : 'Matricule'),
                    ),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: isAr ? 'الاسم والنسب' : 'Nom Complet'),
                    ),
                    TextField(
                      controller: centerController,
                      decoration: InputDecoration(labelText: isAr ? 'مركز العمل' : 'Poste'),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: isAr ? Alignment.centerRight : Alignment.centerLeft,
                      child: Text(isAr ? 'أيام الراحة:' : 'Jours de repos:'),
                    ),
                    Wrap(
                      spacing: 6,
                      children: _daysOfWeek.map((day) {
                        final isSelected = selectedRestDays.contains(day);
                        return FilterChip(
                          label: Text(day),
                          selected: isSelected,
                          onSelected: (val) {
                            setDialogState(() {
                              if (val) {
                                selectedRestDays.add(day);
                              } else {
                                selectedRestDays.remove(day);
                              }
                            });
                          },
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(isAr ? 'إلغاء' : 'Annuler'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (idController.text.isNotEmpty && nameController.text.isNotEmpty) {
                      setState(() {
                        final newEmp = Employee(
                          id: idController.text,
                          name: nameController.text,
                          workCenter: centerController.text,
                          restDays: selectedRestDays,
                        );
                        if (employee == null) {
                          _allEmployees.add(newEmp);
                        } else if (index != null) {
                          _allEmployees[index] = newEmp;
                        }
                        _filterData();
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text(isAr ? 'حفظ' : 'Enregistrer'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAr = widget.currentLocale.languageCode == 'ar';
    final workCenters = _allEmployees.map((e) => e.workCenter).toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(isAr ? 'إدارة طاقم العمل' : 'Gestion du Personnel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: widget.onToggleLanguage,
            tooltip: isAr ? 'Changer en Français' : 'تغيير إلى العربية',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: isAr ? 'بحث بالاسم، الرقم أو مركز العمل...' : 'Recherche...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (val) {
                _searchQuery = val;
                _filterData();
              },
            ),
          ),
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: ChoiceChip(
                    label: Text(isAr ? 'كل الأيام' : 'Tous les jours'),
                    selected: _selectedDay == null,
                    onSelected: (sel) {
                      setState(() {
                        _selectedDay = null;
                        _filterData();
                      });
                    },
                  ),
                ),
                ..._daysOfWeek.map((day) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(day),
                      selected: _selectedDay == day,
                      onSelected: (sel) {
                        setState(() {
                          _selectedDay = sel ? day : null;
                          _filterData();
                        });
                      },
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                ChoiceChip(
                  label: Text(isAr ? 'كل المراكز' : 'Tous les postes'),
                  selected: _selectedWorkCenter == null,
                  onSelected: (sel) {
                    setState(() {
                      _selectedWorkCenter = null;
                      _filterData();
                    });
                  },
                ),
                ...workCenters.map((center) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(center),
                      selected: _selectedWorkCenter == center,
                      onSelected: (sel) {
                        setState(() {
                          _selectedWorkCenter = sel ? center : null;
                          _filterData();
                        });
                      },
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredEmployees.length,
              itemBuilder: (context, index) {
                final emp = _filteredEmployees[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(emp.id.replaceAll('EMP-', '')),
                    ),
                    title: Text(emp.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${isAr ? "المركز" : "Poste"}: ${emp.workCenter}'),
                        Text('${isAr ? "الراحة" : "Repos"}: ${emp.restDays.join("، ")}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        final originalIndex = _allEmployees.indexOf(emp);
                        _showAddEditDialog(employee: emp, index: originalIndex);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
