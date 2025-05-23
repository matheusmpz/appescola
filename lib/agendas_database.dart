import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String tableEvento = "evento";

  static Future<Database> getDatabase() async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      join(dbPath, "dbTarefas.db"),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableEvento (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            evento TEXT NOT NULL,
            data TEXT NOT NULL
          )        
      ''');
      },
      version: 1,
    );
  }

  // Create
  static Future<void> adicionarEvento(String evento, String data) async {
    final db = await getDatabase();
    await db.insert(
      tableEvento,
      {'evento': evento, 'data': data},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read
  static Future<List<Map<String, dynamic>>> getEventos() async {
    final db = await getDatabase();
    return db.query(tableEvento);
  }

  // Delete
  static Future<void> deletarEvento(int id) async {
    final db = await getDatabase();
    await db.delete(
      tableEvento,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
