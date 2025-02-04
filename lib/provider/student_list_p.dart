import 'package:flutter/material.dart';
import 'package:students_app_provider/database/database.dart';
import 'package:students_app_provider/model/student_mode.dart';

class StudentListProvider extends ChangeNotifier {
  late DatabaseHelper databaseHelper;
  List<Student> students = [];
  List<Student> filteredStudents = [];
  bool isSearching = false;

  StudentListProvider() {
    databaseHelper = DatabaseHelper();
    refreshStudentList();
  }

  Future<void> refreshStudentList() async {
    final studentList = await databaseHelper.getStudents();
    students = studentList;
    filteredStudents = studentList;
    notifyListeners();
  }

  void toggleSearch() {
    isSearching = !isSearching;
    if (!isSearching) {
      filteredStudents = students;
    }
    notifyListeners();
  }

  void filterStudents(String query) {
    if (query.isEmpty) {
      filteredStudents = students;
    } else {
      filteredStudents = students
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
