
import 'dart:convert';
import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(const StateApp());
}

class StateApp extends StatelessWidget {
  const StateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student State App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7E57C2),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F1FF),
      ),
      home: const StudentPage(),
    );
  }
}

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  List<Student> students = [];

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController courseController =
      TextEditingController();

  int nextId = 1;

  final List<Color> cardColors = [
    const Color(0xFFEDE7F6),
    const Color(0xFFE3F2FD),
    const Color(0xFFE8F5E9),
    const Color(0xFFFFF3E0),
  ];

  void addStudent() {
    if (nameController.text.trim().isEmpty ||
        courseController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter student name and course'),
          backgroundColor: Color(0xFF7E57C2),
        ),
      );
      return;
    }

    Student student = Student(
      id: nextId,
      name: nameController.text.trim(),
      course: courseController.text.trim(),
    );

    // Convert Student object to JSON.
    Map<String, dynamic> data = student.toJson();

    // Convert Map to JSON String.
    String jsonData = jsonEncode(data);

    // Convert JSON String back to Map.
    Map<String, dynamic> decodedData = jsonDecode(jsonData);

    // Convert JSON back to Student object.
    Student newStudent = Student.fromJson(decodedData);

    print('JSON Data: $jsonData');
    print('Student Name: ${newStudent.name}');

    setState(() {
      students.add(newStudent);
      nextId++;
    });

    nameController.clear();
    courseController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${newStudent.name} added successfully'),
        backgroundColor: const Color(0xFF6A4BBC),
      ),
    );
  }

  void removeStudent(int index) {
    String name = students[index].name;

    setState(() {
      students.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name removed'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7E57C2),
        foregroundColor: Colors.white,
        elevation: 3,
        centerTitle: true,
        title: const Text(
          'Student State & JSON',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const Icon(Icons.school),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              elevation: 4,
              shadowColor: const Color(0x557E57C2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Add New Student',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5E35B1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Student Name',
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Color(0xFF7E57C2),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF8F5FF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: courseController,
                      decoration: InputDecoration(
                        labelText: 'Course',
                        prefixIcon: const Icon(
                          Icons.menu_book,
                          color: Color(0xFF7E57C2),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF8F5FF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: addStudent,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7E57C2),
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text(
                          'Add Student',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Student List',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4527A0),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE7F6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.people,
                        size: 18,
                        color: Color(0xFF6A4BBC),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${students.length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6A4BBC),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: students.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Color(0xFFEDE7F6),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.people_outline,
                              size: 55,
                              color: Color(0xFF7E57C2),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'No students added yet',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6D6D6D),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Add a student using the form above',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        final Color cardColor =
                            cardColors[index % cardColors.length];

                        return Card(
                          color: cardColor,
                          elevation: 2,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: const Color(0xFF7E57C2),
                              child: Text(
                                '${student.id}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              student.name,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3E3E3E),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.school,
                                    size: 16,
                                    color: Color(0xFF6A4BBC),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      student.course,
                                      style: const TextStyle(
                                        color: Color(0xFF666666),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: IconButton(
                              tooltip: 'Delete',
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
                              ),
                              onPressed: () => removeStudent(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
