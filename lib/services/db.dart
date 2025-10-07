
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import '../models/registration.dart';

class AppDb {
  AppDb._();
  static final AppDb instance = AppDb._();
  Database? _db;

  Future<Database> _open() async {
    if (_db != null) return _db!;
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'as11_event.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE registrations(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            student_id TEXT NOT NULL,
            first_name TEXT NOT NULL,
            last_name TEXT NOT NULL,
            program TEXT NOT NULL,
            activity_name TEXT NOT NULL,
            created_at TEXT NOT NULL,
            user_uid TEXT NOT NULL
          );
        ''');
      },
    );
    return _db!;
  }

  Future<int> insert(Registration r) async {
    final db = await _open();
    return db.insert('registrations', r.toMap());
  }

  Future<List<Registration>> getAll(String userUid) async {
    final db = await _open();
    final rows = await db.query(
      'registrations',
      where: 'user_uid = ?',
      whereArgs: [userUid],
      orderBy: 'id DESC',
    );
    return rows.map((e) => Registration.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    final db = await _open();
    return db.delete('registrations', where: 'id = ?', whereArgs: [id]);
  }
}
