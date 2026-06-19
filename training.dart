// ignore_for_file: unused_local_variable, unused_import, unused_element, unused_field
import 'dart:io';

class Students {
  String name;
  double grade;

  Students(this.name, this.grade);
}

class StudentsManager {
  List<Students> stu = [];

  void add(String name, double grade) {
    if (stu.any((x) => x.name == name)) {
      print("Student already enameists!");
    } else {
      stu.add(Students(name, grade));
      print("The student was added successfully");
    }
  }

  void edit(String name) {
    if (stu.any((x) => x.name == name)) {
      print("Enter the new name after editing : ");

      String? input = stdin.readLineSync();

      if (input != null) {
        if (stu.any((x) => x.name == input)) {
          print("This name already enameists!");
        } else {
          var student = stu.firstWhere((x) => x.name == name);
          student.name = input;

          print("The student was edited successfully");
        }
      } else {
        print("Please Enter a valid name! ");
      }
    } else {
      print("This name doesn't enameist!");
    }
  }

  void delete(String name) {
    if (stu.any((x) => x.name == name)) {
      stu.removeWhere((student) => student.name == name);

      print("The student was deleted successfully");
    } else {
      print("This name doesn't enameist!");
    }
  }

  void showAll() {
    for (var s in stu) {
      print("Name: ${s.name} - Grade: ${s.grade}");
    }
  }

  void editGrade(String name, double newGrade) {
    if (stu.any((x) => x.name == name)) {
      var student = stu.firstWhere((x) => x.name == name);
      student.grade = newGrade;
      print("Updated");
    } else {
      print("Not found");
    }
  }

  void average() {
    if (stu.isEmpty) {
      print("No grades available");
      return;
    }
    double sum = 0;
    for (var student in stu) {
      sum += student.grade;
    }

    double averages = sum / stu.length;
    print("The average of grades is : $averages");
  }

  void max() {
    if (stu.isEmpty) {
      print("No grades available");
      return;
    }

    double maxGrade = stu.first.grade;
    for (var student in stu) {
      if (student.grade > maxGrade) {
        maxGrade = student.grade;
      }
    }
    print("The max grade is : $maxGrade");
  }

  void min() {
    if (stu.isEmpty) {
      print("No grades available");
      return;
    }
    double minGrade = stu.first.grade;

    for (var student in stu) {
      if (student.grade < minGrade) {
        minGrade = student.grade;
      }
    }

    print("The min grade is : $minGrade");
  }
}

void main() {
  var obj = StudentsManager();
  while (true) {
    print("Welcome");
    print("Choose what you want : ");
    print("1 : add student \n2 : edit student ");
    print("3 : delete student \n4 : show all students ");
    print("5 : number of stu \n6 : show first and last student ");
    print("7 : edit grade \n8 : average ");
    print("9 : max grade \n10 : min grade");

    String? input = stdin.readLineSync();
    int? inputs = int.tryParse(input ?? '');

    if (inputs == null) {
      print("Invalid input");
      continue;
    }

    switch (inputs) {
      case 1:
        print("Enter the name and the grade of student : ");
        String? name = stdin.readLineSync();

        String? grades = stdin.readLineSync();
        double? grade = double.tryParse(grades ?? '');

        if (name != null && grade != null) obj.add(name, grade);
        break;

      case 2:
        if (obj.stu.isEmpty) {
          print("The List is empty!");
          break;
        }
        print("Enter the name of student : ");
        String? student = stdin.readLineSync();

        if (student != null) obj.edit(student);
        break;

      case 3:
        if (obj.stu.isEmpty) {
          print("The List is empty!");
          break;
        }
        print("Enter the name of student : ");
        String? dell = stdin.readLineSync();
        if (dell != null) obj.delete(dell);
        break;

      case 4:
        obj.showAll();
        break;

      case 5:
        print(obj.stu.length);
        break;

      case 6:
        if (obj.stu.isEmpty) {
          print("The List is empty!");
          break;
        }
        print(
          "The first student is : ${obj.stu.first.name} \nThe last student is : ${obj.stu.last.name}",
        );
        break;

      case 7:
        if (obj.stu.isEmpty) {
          print("No grades to edit!");
          break;
        }

        print("Enter student name to edit grade: ");
        String? editName = stdin.readLineSync();

        if (editName == null) break;

        print("Enter new grade: ");
        String? newGradeInput = stdin.readLineSync();
        double? newGrade = double.tryParse(newGradeInput ?? '');

        if (newGrade != null) {
          obj.editGrade(editName, newGrade);
        } else {
          print("Invalid grade!");
        }
        break;

      case 8:
        obj.average();
        break;

      case 9:
        obj.max();
        break;

      case 10:
        obj.min();
        break;
    }
    while (true) {
      print("Do you want to do another operation ? (y/n)");
      String? op = stdin.readLineSync();
      if (op == 'n')
        return;
      else if (op == 'y')
        break;
      else
        print("Please choose (y/n)!");
    }
  }
}
