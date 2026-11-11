import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/design.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  final StreamController<List<Design>> _designsStreamController =
      StreamController<List<Design>>.broadcast();

  DatabaseHelper._init();

  Stream<List<Design>> get designsStream {
    _refreshStream();
    return _designsStreamController.stream;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('meme_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE designs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        text TEXT NOT NULL,
        bottomText TEXT,
        backgroundColorValue INTEGER NOT NULL,
        textColorValue INTEGER NOT NULL,
        fontSize REAL NOT NULL
      )
    ''');

    // Insert initial sample design
    await db.insert('designs', {
      'title': 'Classic Meme',
      'text': 'When code runs without bugs',
      'bottomText': 'Unbelievable!',
      'backgroundColorValue': 0xFF673AB7,
      'textColorValue': 0xFFFFFFFF,
      'fontSize': 28.0,
    });
  }

  Future<int> insertDesign(Design design) async {
    final db = await instance.database;
    final id = await db.insert('designs', design.toMap());
    _refreshStream();
    return id;
  }

  Future<List<Design>> getDesigns() async {
    final db = await instance.database;
    final maps = await db.query('designs', orderBy: 'id DESC');
    return maps.map((map) => Design.fromMap(map)).toList();
  }

  Future<List<Design>> searchDesigns(String query) async {
    final db = await instance.database;
    if (query.trim().isEmpty) {
      return getDesigns();
    }
    final maps = await db.query(
      'designs',
      where: 'title LIKE ? OR text LIKE ? OR bottomText LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
      orderBy: 'id DESC',
    );
    return maps.map((map) => Design.fromMap(map)).toList();
  }

  Future<int> deleteDesign(int id) async {
    final db = await instance.database;
    final rows = await db.delete(
      'designs',
      where: 'id = ?',
      whereArgs: [id],
    );
    _refreshStream();
    return rows;
  }

  Future<void> _refreshStream() async {
    try {
      final designs = await getDesigns();
      _designsStreamController.add(designs);
    } catch (_) {}
  }

  void dispose() {
    _designsStreamController.close();
  }
}
