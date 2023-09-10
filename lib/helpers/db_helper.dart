import 'package:flutter_projects/models/student.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{

  Future initDb() async {
    final db = openDatabase(join(await getDatabasesPath(), 'students.db'),
        version: 1, onCreate: (db, version) {
          return db.execute(
              'Create Table students (id INTEGER PRIMARY KEY,name Text,age INTEGER');
        });
  }
  insertStudent(Student std)async{
    
  }
}
