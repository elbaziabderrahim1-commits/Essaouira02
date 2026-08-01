import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const StaffManagerApp());
}

class StaffManagerApp extends StatelessWidget {
  const StaffManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'إدارة طاقم العمل',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'MA'),
      supportedLocales: const [Locale('ar', 'MA')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        fontFamily: 'Roboto',
      ),
      home: const StaffListScreen(),
    );
  }
}

class Employee {
  final String id;
  final String name;
  final String center;
  final String restDays;
  final String category; // تصنيف القسم لتسهيل البحث

  Employee({
    required this.id,
    required this.name,
    required this.center,
    required this.restDays,
    required this.category,
  });
}

class StaffListScreen extends StatefulWidget {
  const StaffListScreen({super.key});

  @override
  State<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  String _selectedDayFilter = 'كل الأيام';
  String _selectedCategoryFilter = 'الكل';

  // أقسام واضحة وسهلة لتصفية الموظفين
  final List<String> _categoryFilters = [
    'الكل',
    'الحي الأول',
    'الحي الثاني',
    'الحي الثالث',
    'حي النساء',
    'قاعة الزيارة',
    'باب المعقل والمدخل',
    'المستشفى والخفر',
    'فرقة الحراسة الليلية',
    'الأمن الخارجي والبرج',
    'وظائف أخرى',
  ];

  final List<String> _dayFilters = [
    'كل الأيام',
    'السبت',
    'الأحد',
    'الإثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
  ];

  late List<Employee> _allEmployees;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    _allEmployees = [
      // إدارة المعقل
      Employee(id: "EMP-1001", name: "خلفاوي الحسين", center: "رئيس المعقل", restDays: "السبت-الأحد", category: "باب المعقل والمدخل"),
      Employee(id: "EMP-1002", name: "زكرياء الكفيش", center: "نائب رئيس المعقل", restDays: "السبت-الأحد", category: "باب المعقل والمدخل"),
      Employee(id: "EMP-1003", name: "البازي عبد الرحيم", center: "نائب رئيس المعقل", restDays: "السبت-الأحد", category: "باب المعقل والمدخل"),
      Employee(id: "EMP-1004", name: "عبد الله بشبلا", center: "نائب رئيس المعقل", restDays: "الخميس-الجمعة", category: "باب المعقل والمدخل"),
      Employee(id: "EMP-1005", name: "علي الحراث", center: "نائب رئيس المعقل", restDays: "الثلاثاء-الأربعاء", category: "باب المعقل والمدخل"),
      Employee(id: "EMP-1006", name: "عبد الرحمان وركة", center: "التصنيف والايواء", restDays: "السبت-الأحد", category: "باب المعقل والمدخل"),
      Employee(id: "EMP-1007", name: "سعید الهواري", center: "ضبط سجلات باب المعقل", restDays: "السبت-الأحد", category: "باب المعقل والمدخل"),
      Employee(id: "EMP-1008", name: "موسى بوري", center: "التفتيش في باب المعقل", restDays: "السبت-الأحد", category: "باب المعقل والمدخل"),
      Employee(id: "EMP-1009", name: "خالد اوقاس", center: "ضبط حركة باب المعقل", restDays: "الجمعة-السبت", category: "باب المعقل والمدخل"),
      Employee(id: "EMP-1010", name: "محمد عبيد", center: "ضبط حركة باب المعقل", restDays: "الأربعاء-الخميس", category: "باب المعقل والمدخل"),
      
      // المستشفى والخفر
      Employee(id: "EMP-1011", name: "نور الدين جبارري", center: "الخفر إلى المستشفى", restDays: "السبت-الأحد", category: "المستشفى والخفر"),
      Employee(id: "EMP-1012", name: "عبد الحق العلمي", center: "الخفر إلى المستشفى", restDays: "السبت-الأحد", category: "المستشفى والخفر"),
      Employee(id: "EMP-1013", name: "مهدي عزامي", center: "الخفر إلى المستشفى", restDays: "السبت-الأحد", category: "المستشفى والخفر"),
      Employee(id: "EMP-1014", name: "بلمهدي عز الدين", center: "الخفر إلى المستشفى", restDays: "السبت-الأحد", category: "المستشفى والخفر"),
      
      // الحي الأول
      Employee(id: "EMP-1015", name: "خالد الغربة", center: "رئيس الحي الأول", restDays: "الأربعاء-الخميس", category: "الحي الأول"),
      Employee(id: "EMP-1016", name: "احمد ابوزيا", center: "نائب رئيس الحي الأول", restDays: "السبت-الأحد", category: "الحي الأول"),
      Employee(id: "EMP-1017", name: "حمادي محمد", center: "الحي الأول الجناح الأول", restDays: "الإثنين-الثلاثاء", category: "الحي الأول"),
      Employee(id: "EMP-1018", name: "ياسين اعميمي", center: "الحي الأول الجناح الأول", restDays: "السبت-الأحد", category: "الحي الأول"),
      Employee(id: "EMP-1019", name: "عبد الكريم الحنفي", center: "الحي الأول الجناح الثاني", restDays: "الثلاثاء-الأربعاء", category: "الحي الأول"),
      Employee(id: "EMP-1020", name: "محمد حاقيضي", center: "الحي الأول الجناح الثاني", restDays: "الخميس-الجمعة", category: "الحي الأول"),
      Employee(id: "EMP-1021", name: "خالد عكوري", center: "الحي الأول الجناح الثالث", restDays: "الثلاثاء-الأربعاء", category: "الحي الأول"),
      Employee(id: "EMP-1022", name: "التاج محمد", center: "الحي الأول الجناح الثالث", restDays: "الخميس-الجمعة", category: "الحي الأول"),
      Employee(id: "EMP-1023", name: "ابراهيم المجدي", center: "باب الحي الأول", restDays: "الثلاثاء-الأربعاء", category: "الحي الأول"),
      Employee(id: "EMP-1024", name: "مهدي ادراوي", center: "فسحة الحي الأول", restDays: "السبت-الأحد", category: "الحي الأول"),
      Employee(id: "EMP-1076", name: "عبد الصادق الصابر", center: "فواصل الحي الأول", restDays: "الثلاثاء-الأربعاء", category: "الحي الأول"),

      // الحي الثاني
      Employee(id: "EMP-1025", name: "حسن عمري", center: "رئيس الحي الثاني", restDays: "الإثنين-الثلاثاء", category: "الحي الثاني"),
      Employee(id: "EMP-1026", name: "مهدي بنعشى", center: "نائب رئيس الحي الثاني", restDays: "الأربعاء-الخميس", category: "الحي الثاني"),
      Employee(id: "EMP-1027", name: "حسن بنخديجة", center: "الجناح الأول الحي الثاني", restDays: "الأربعاء-الخميس", category: "الحي الثاني"),
      Employee(id: "EMP-1028", name: "ادريس ايت عيسى", center: "الجناح الأول الحي الثاني", restDays: "السبت-الأحد", category: "الحي الثاني"),
      Employee(id: "EMP-1029", name: "هني عبد اللطيف", center: "الجناح الثاني الحي الثاني", restDays: "الخميس-الجمعة", category: "الحي الثاني"),
      Employee(id: "EMP-1030", name: "ياسين حاقيضي", center: "الجناح الثاني الحي الثاني", restDays: "الثلاثاء-الأربعاء", category: "الحي الثاني"),
      Employee(id: "EMP-1031", name: "عبد العظيم فريد", center: "الجناح الثاني الحي الثاني", restDays: "السبت-الأحد", category: "الحي الثاني"),
      Employee(id: "EMP-1032", name: "عمران اوحميدوش", center: "فسحة الحي الثاني", restDays: "الثلاثاء-الأربعاء", category: "الحي الثاني"),

      // الحي الثالث
      Employee(id: "EMP-1033", name: "وحمان يوسف", center: "رئيس الحي الثالث", restDays: "السبت-الأحد", category: "الحي الثالث"),
      Employee(id: "EMP-1034", name: "محمد الكنطاري", center: "نائب رئيس الحي الثالث", restDays: "الأربعاء-الخميس", category: "الحي الثالث"),
      Employee(id: "EMP-1035", name: "مصعب بوعلام", center: "الحي الثالث الجناح الأول", restDays: "الإثنين-الثلاثاء", category: "الحي الثالث"),
      Employee(id: "EMP-1036", name: "عبد الرحمان العوفي", center: "الحي الثالث الجناح الأول", restDays: "السبت-الأحد", category: "الحي الثالث"),
      Employee(id: "EMP-1037", name: "سيف الدين العبار", center: "الحي الثالث الجناح الثاني", restDays: "السبت-الأحد", category: "الحي الثالث"),
      Employee(id: "EMP-1038", name: "وليد كمال", center: "الحي الثالث الجناح الثاني", restDays: "الخميس-الجمعة", category: "الحي الثالث"),
      Employee(id: "EMP-1039", name: "رضى بنكايس", center: "الحي الثالث الجناح الثالث", restDays: "الخميس-الجمعة", category: "الحي الثالث"),
      Employee(id: "EMP-1040", name: "يونس حنيكيش", center: "الحي الثالث الجناح الثالث", restDays: "السبت-الأحد", category: "الحي الثالث"),
      Employee(id: "EMP-1041", name: "ياسين الغلوات", center: "فسحة الحي الثالث", restDays: "السبت-الأحد", category: "الحي الثالث"),
      Employee(id: "EMP-1050", name: "عبد الرحمان تحيري", center: "باب الحي الثالث", restDays: "السبت-الأحد", category: "الحي الثالث"),
      Employee(id: "EMP-1067", name: "اسامة بلوش", center: "فواصل الحي الثالث", restDays: "السبت-الأحد", category: "الحي الثالث"),
      Employee(id: "EMP-1075", name: "عبد الصمد السحيمي", center: "فواصل الحي الثالث", restDays: "السبت-الأحد", category: "الحي الثالث"),

      // قاعة الزيارة
      Employee(id: "EMP-1042", name: "رضى اغفار", center: "احضار السجناء الى قاعة الزيارة", restDays: "السبت-الأحد", category: "قاعة الزيارة"),
      Employee(id: "EMP-1043", name: "حسن بكاري", center: "التفتيش في قاعة الزيارة", restDays: "الجمعة-السبت", category: "قاعة الزيارة"),
      Employee(id: "EMP-1044", name: "محمد مكناوي", center: "المسؤول عن قاعة الزيارة", restDays: "السبت-الأحد", category: "قاعة الزيارة"),
      Employee(id: "EMP-1047", name: "عبد الحكيم دكاير", center: "الزيارة المواعيد", restDays: "السبت-الأحد", category: "قاعة الزيارة"),
      Employee(id: "EMP-1048", name: "المهدي ديباني", center: "تفتيش المؤونة", restDays: "السبت-الأحد", category: "قاعة الزيارة"),
      Employee(id: "EMP-1049", name: "رضا نادر", center: "تفتيش الزوار", restDays: "السبت-الأحد", category: "قاعة الزيارة"),
      Employee(id: "EMP-1053", name: "الهام البجاوي", center: "تنظيم الزيارة", restDays: "السبت-الأحد", category: "قاعة الزيارة"),
      Employee(id: "EMP-1054", name: "مؤنى المشماشي", center: "قاعة الزيارة", restDays: "السبت-الأحد", category: "قاعة الزيارة"),
      Employee(id: "EMP-1055", name: "نادية احموش", center: "تفتيش المؤونة", restDays: "السبت-الأحد", category: "قاعة الزيارة"),
      Employee(id: "EMP-1056", name: "حليمة الجرموني", center: "تفتيش الزائرات", restDays: "السبت-الأحد", category: "قاعة الزيارة"),
      Employee(id: "EMP-1057", name: "سلمى الروينكو", center: "الاستقبال والتوجيه", restDays: "السبت-الأحد", category: "قاعة الزيارة"),
      Employee(id: "EMP-1058", name: "خديجة بلمقدم", center: "تفتيش الزائرات", restDays: "السبت-الأحد", category: "قاعة الزيارة"),
      Employee(id: "EMP-1059", name: "حكيمة القويقري", center: "قاعة الزيارة", restDays: "السبت-الأحد", category: "قاعة الزيارة"),
      Employee(id: "EMP-1060", name: "نادية البغدادي", center: "تسلم الأموال من الزوار", restDays: "السبت-الأحد", category: "قاعة الزيارة"),

      // حي النساء
      Employee(id: "EMP-1062", name: "بشرى العرفاوي", center: "نائبة رئيسة حي النساء", restDays: "الخميس-الجمعة", category: "حي النساء"),
      Employee(id: "EMP-1063", name: "يسرى الرامي", center: "رئيسة حي النساء", restDays: "السبت-الأحد", category: "حي النساء"),
      Employee(id: "EMP-1064", name: "فاطمة حكيمي", center: "حي النساء التكوين", restDays: "السبت-الأحد", category: "حي النساء"),

      // الأبواب والأمن الخارجي والبرج
      Employee(id: "EMP-1045", name: "الموتشو عبد الفتاح", center: "باب الموظفين", restDays: "السبت-الأحد", category: "الأمن الخارجي والبرج"),
      Employee(id: "EMP-1046", name: "الحيمر محمد", center: "باب المرتفقين", restDays: "السبت-الأحد", category: "الأمن الخارجي والبرج"),
      Employee(id: "EMP-1051", name: "عزيز الديبالي", center: "الحراسة في الضبط القضائي", restDays: "السبت-الأحد", category: "الأمن الخارجي والبرج"),
      Employee(id: "EMP-1052", name: "الرحالي مصطفى", center: "رئيس الأمن الخارجي", restDays: "السبت-الأحد", category: "الأمن الخارجي والبرج"),
      Employee(id: "EMP-1061", name: "عبد العزيز الصديقي", center: "نائب الأمن الخارجي", restDays: "السبت-الأحد", category: "الأمن الخارجي والبرج"),
      Employee(id: "EMP-1065", name: "هلودي يونس", center: "باب الإيقاف", restDays: "السبت-الأحد", category: "الأمن الخارجي والبرج"),
      Employee(id: "EMP-1068", name: "رضى نور الدين", center: "البرج 4", restDays: "السبت-الأحد", category: "الأمن الخارجي والبرج"),
      Employee(id: "EMP-1070", name: "السقاف مهدي", center: "الملتقى 1", restDays: "الجمعة-السبت", category: "الأمن الخارجي والبرج"),
      Employee(id: "EMP-1126", name: "محمد", center: "الحراسة في الباب الرسم السامري", restDays: "السبت-الأحد", category: "الأمن الخارجي والبرج"),
      Employee(id: "EMP-1127", name: "ايوب المغيثي", center: "باب الإيقاف", restDays: "الإثنين-الثلاثاء", category: "الأمن الخارجي والبرج"),

      // فرقة الحراسة الليلية
      Employee(id: "EMP-1078", name: "اجبلي خالد", center: "فرقة الحراسة 1", restDays: "فرقة 1", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1079", name: "طارق العبسي", center: "فرقة الحراسة 1", restDays: "فرقة 1", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1080", name: "يونس جبور", center: "فرقة الحراسة 1", restDays: "فرقة 1", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1081", name: "عبد الله العلوي", center: "فرقة الحراسة 1", restDays: "فرقة 1", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1082", name: "المقداوي المحجوب", center: "فرقة الحراسة 1", restDays: "فرقة 1", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1083", name: "اسامة عبو", center: "فرقة الحراسة 1", restDays: "فرقة 1", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1084", name: "هشام الخوخي", center: "فرقة الحراسة 1", restDays: "فرقة 1", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1085", name: "بوغصا يوسف", center: "فرقة الحراسة 1", restDays: "فرقة 1", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1086", name: "امين بنعلال", center: "فرقة الحراسة 1", restDays: "فرقة 1", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1087", name: "يوسف صبير", center: "فرقة الحراسة 1", restDays: "فرقة 1", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1088", name: "يوسف عمري", center: "فرقة الحراسة 1", restDays: "فرقة 1", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1089", name: "شرف الدين تيكي", center: "فرقة الحراسة 1", restDays: "فرقة 1", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1090", name: "محمد امين لوغو", center: "فرقة الحراسة 1", restDays: "فرقة 1", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1091", name: "امينة الكارمة", center: "فرقة الحراسة 1", restDays: "فرقة 1", category: "فرقة الحراسة الليلية"),
      
      Employee(id: "EMP-1092", name: "عبد الواحد السوسي", center: "فرقة الحراسة 2", restDays: "فرقة 2", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1093", name: "العلاوي ادريس", center: "فرقة الحراسة 2", restDays: "فرقة 2", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1094", name: "عادل اوشاهد", center: "فرقة الحراسة 2", restDays: "فرقة 2", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1095", name: "عبد الفتاح الكركاكي", center: "فرقة الحراسة 2", restDays: "فرقة 2", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1096", name: "عبد اللطيف الدحماني", center: "فرقة الحراسة 2", restDays: "فرقة 2", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1097", name: "ياسين لحمدي", center: "فرقة الحراسة 2", restDays: "فرقة 2", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1098", name: "محمد ابنطير", center: "فرقة الحراسة 2", restDays: "فرقة 2", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1099", name: "الحسين فراج", center: "فرقة الحراسة 2", restDays: "فرقة 2", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1100", name: "دنيا النعامي", center: "فرقة الحراسة 2", restDays: "فرقة 2", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1101", name: "مريم الديخ", center: "فرقة الحراسة 2", restDays: "فرقة 2", category: "فرقة الحراسة الليلية"),

      Employee(id: "EMP-1102", name: "سعيد الزنزون", center: "فرقة الحراسة 3", restDays: "فرقة 3", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1103", name: "باطش عبد الرحمان", center: "فرقة الحراسة 3", restDays: "فرقة 3", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1104", name: "حمزة الفر", center: "فرقة الحراسة 3", restDays: "فرقة 3", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1105", name: "عبد الاله لكحل", center: "فرقة الحراسة 3", restDays: "فرقة 3", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1106", name: "عثمان بوستى", center: "فرقة الحراسة 3", restDays: "فرقة 3", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1107", name: "اسامة اهكو", center: "فرقة الحراسة 3", restDays: "فرقة 3", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1108", name: "عصام بنخديجة", center: "فرقة الحراسة 3", restDays: "فرقة 3", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1109", name: "عمرو الهندي", center: "فرقة الحراسة 3", restDays: "فرقة 3", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1110", name: "سفيان البغراوي", center: "فرقة الحراسة 3", restDays: "فرقة 3", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1111", name: "انجار عبد العزيز", center: "فرقة الحراسة 3", restDays: "فرقة 3", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1112", name: "امينة مهاجر", center: "فرقة الحراسة 3", restDays: "فرقة 3", category: "فرقة الحراسة الليلية"),

      Employee(id: "EMP-1113", name: "الشابني محمد", center: "فرقة الحراسة 4", restDays: "فرقة 4", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1114", name: "مصطفى حيمي", center: "فرقة الحراسة 4", restDays: "فرقة 4", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1115", name: "محمد اسرار", center: "فرقة الحراسة 4", restDays: "فرقة 4", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1116", name: "وليد بوخيمة", center: "فرقة الحراسة 4", restDays: "فرقة 4", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1117", name: "العواد عبد الصمد", center: "فرقة الحراسة 4", restDays: "فرقة 4", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1118", name: "زكرياء جاري", center: "فرقة الحراسة 4", restDays: "فرقة 4", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1119", name: "المهدي الجنين", center: "فرقة الحراسة 4", restDays: "فرقة 4", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1120", name: "عبد الصمد امغران", center: "فرقة الحراسة 4", restDays: "فرقة 4", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1121", name: "ادريس المغراوي", center: "فرقة الحراسة 4", restDays: "فرقة 4", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1122", name: "مروان اصريحات", center: "فرقة الحراسة 4", restDays: "فرقة 4", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1123", name: "عبد العالي الهميص", center: "فرقة الحراسة 4", restDays: "فرقة 4", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1124", name: "هاجر المزوهر", center: "فرقة الحراسة 4", restDays: "فرقة 4", category: "فرقة الحراسة الليلية"),
      Employee(id: "EMP-1125", name: "حليمة اشهيبة", center: "فرقة الحراسة 4", restDays: "فرقة 4", category: "فرقة الحراسة الليلية"),

      // وظائف أخرى وسجن قديم
      Employee(id: "EMP-1066", name: "الختاني محمد", center: "المكلف بالنظافة", restDays: "السبت-الأحد", category: "وظائف أخرى"),
      Employee(id: "EMP-1069", name: "محمد امين الناصري", center: "المكلف بالمخالفات", restDays: "السبت-الأحد", category: "وظائف أخرى"),
      Employee(id: "EMP-1071", name: "شرعا محمد", center: "الحراسة في السجن القديم", restDays: "حسب نظام الحراسة", category: "وظائف أخرى"),
      Employee(id: "EMP-1072", name: "رحالي عبد الحكيم", center: "الحراسة في السجن القديم", restDays: "حسب نظام الحراسة", category: "وظائف أخرى"),
      Employee(id: "EMP-1073", name: "عبد الله تنباكور", center: "الحراسة في السجن القديم", restDays: "حسب نظام الحراسة", category: "وظائف أخرى"),
      Employee(id: "EMP-1074", name: "الدوبية سعيد", center: "الحراسة في السجن القديم", restDays: "حسب نظام الحراسة", category: "وظائف أخرى"),
      Employee(id: "EMP-1077", name: "محمد عواج", center: "المداومة الليلية", restDays: "حسب نظام المداومة", category: "وظائف أخرى"),
      Employee(id: "EMP-1132", name: "محمد القليعي", center: "موقوف عن العمل", restDays: "-", category: "وظائف أخرى"),
      Employee(id: "EMP-1133", name: "محمد الصديقي", center: "التكوين المستمر", restDays: "-", category: "وظائف أخرى"),
      Employee(id: "EMP-1134", name: "عبد الله مساعد", center: "رخصة مرضية", restDays: "-", category: "وظائف أخرى"),
    ];
  }

  List<Employee> get _filteredEmployees {
    return _allEmployees.where((emp) {
      final query = _searchController.text.trim().toLowerCase();
      
      final matchesQuery = query.isEmpty ||
          emp.name.toLowerCase().contains(query) ||
          emp.id.toLowerCase().contains(query) ||
          emp.center.toLowerCase().contains(query);

      final matchesDay = _selectedDayFilter == 'كل الأيام' ||
          emp.restDays.contains(_selectedDayFilter);

      final matchesCategory = _selectedCategoryFilter == 'الكل' ||
          emp.category == _selectedCategoryFilter;

      return matchesQuery && matchesDay && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final displayedList = _filteredEmployees;

    return Scaffold(
      appBar: AppBar(
        title: Text('طاقم العمل (${displayedList.length})'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // شريط البحث
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'بحث بالاسم، الرقم أو المهنة...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          
          // فلترة الأقسام والأحياء
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _categoryFilters.length,
              itemBuilder: (context, index) {
                final cat = _categoryFilters[index];
                final isSelected = _selectedCategoryFilter == cat;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: FilterChip(
                    selectedColor: Colors.indigo.shade100,
                    label: Text(
                      cat,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.indigo.shade900 : Colors.black87,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategoryFilter = selected ? cat : 'الكل';
                      });
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 4),

          // فلترة أيام الراحة
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _dayFilters.length,
              itemBuilder: (context, index) {
                final day = _dayFilters[index];
                final isSelected = _selectedDayFilter == day;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: ChoiceChip(
                    label: Text(day, style: const TextStyle(fontSize: 12)),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedDayFilter = day);
                      }
                    },
                  ),
                );
              },
            ),
          ),

          const Divider(height: 16),

          // قائمة الموظفين
          Expanded(
            child: displayedList.isEmpty
                ? const Center(child: Text('لا توجد نتائج مطابقة'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: displayedList.length,
                    itemBuilder: (context, index) {
                      final emp = displayedList[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.indigo.shade50,
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  emp.id,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            emp.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAlignment.start,
                            children: [
                              Text('المهنة/المركز: ${emp.center}'),
                              Text(
                                'الراحة: ${emp.restDays}',
                                style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
