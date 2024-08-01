import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static DatabaseService databaseService = DatabaseService._();

  DatabaseService._();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await createData();
    return _database;
  }

  Future<Database?> createData() async {
    final path = await getDatabasesPath();
    final dataPath = join(path, 'favorite.db');

    _database = await openDatabase(
      dataPath,
      version: 1,
      onCreate: (db, version) {
        String sql = '''
            CREATE TABLE favorite (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            quotes TEXT,
            author TEXT,
            isLike INTEGER,
            category TEXT,
            image TEXT
         )''';
        db.execute(sql);
      },
    );

    return _database;
  }

  Future<void> insertData(
      String? quotes, String? author, bool? isLike, String? category,String? image) async {
    final db = await database;
    String sql =
        'INSERT INTO favorite (quotes,author,isLike,category) VALUES(?,?,?,?,?)';
    List arg = [quotes, author, isLike, category,image];
    await db!.rawInsert(sql, arg);
  }

  Future<List<Map<String, Object?>>> readData() async {
    final db = await database;
    String sql = '''
    SELECT * FROM favorite
    ''';
    return await db!.rawQuery(sql);
  }

  Future<void> removeData(String quotes) async {
    final db = await database;
    String sql = '''
    DELETE FROM favorite WHERE quotes = ?
    ''';
    await db!.rawDelete(sql, [quotes]);
  }
}
