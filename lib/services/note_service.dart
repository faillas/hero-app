
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;
import 'package:test_drive/models/note.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase
    (path.join(dbPath, 'notes.db'), onCreate: (db, version){
      return db.execute('CREATE TABLE notes(id INTEGER PRIMARY KEY autoincrement, description TEXT, type TEXT)');
    },
    version: 1
  );
  return db;
}


class NoteService {

  Future<List> load() async {
    final db = await _getDatabase();
    final data = await db.query('notes');
    final list = data.map((row){
      return Note(
        id: row['id'] as int, 
        description: row['description'] as String, 
        type: row['type'] as String
      );
    }).toList();
    return list;
  }

  void saveNote(String description, String type) async {

    final newNote = Note(
      id: null,
      description: description,
      type: type,     
    );

    final db = await _getDatabase();

    db.insert('notes', {
      'description': newNote.description,
      'type': newNote.type, 
    });

  }

  void delete(id) async {

    final db = await _getDatabase();

    db.delete('notes', where: 'id = $id');

  }


}