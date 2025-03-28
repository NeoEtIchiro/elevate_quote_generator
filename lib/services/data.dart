import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB('elevate.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE quotes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      content TEXT,
      author TEXT
    )
    ''');
  }

  Future<int> addQuote(String content, String author) async {
    final db = await instance.database;

    final data = {'content': content, 'author': author};
    return await db!.insert('quotes', data);
  }

  Future<int> updateQuote(int id, String content, String author) async {
    final db = await instance.database;

    final data = {
      'content': content,
      'author': author,
    };

    return await db!.update(
      'quotes',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteQuote(int id) async {
    final db = await instance.database;

    return await db!.delete('quotes', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAllQuotes() async {
    final db = await instance.database;

    return await db!.query('quotes');
  }

  Future close() async {
    final db = await instance.database;

    db?.close();
  }
}