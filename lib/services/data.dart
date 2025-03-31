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

    return await openDatabase(path, version: 4, onCreate: _createDB, onUpgrade: _upgradeDB);

  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE quotes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      content_en TEXT,
      content_fr TEXT,
      author TEXT
    )
    ''');
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {

      await db.execute('DROP TABLE quotes');
    }
    if (oldVersion < 4) {
      await db.execute('''
      CREATE TABLE quotes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content_en TEXT,
        content_fr TEXT,
        author TEXT
      )
      ''');
    }
  }

  Future<int> addQuote(String contentfr,String contenten, String author) async {
    final db = await instance.database;

    final data = {'content_fr': contentfr, 'content_en': contenten , 'author': author};
    return await db!.insert('quotes', data);
  }

  Future<int> updateQuote(int id, String contentfr, String contenten, String author) async {
    final db = await instance.database;

    final data = {
      'content_fr': contentfr,
      'content_en': contenten,
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