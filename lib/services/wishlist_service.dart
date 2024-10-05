
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

import '../models/wish_item.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase
    (path.join(dbPath, 'wishlist.db'), onCreate: (db, version){
      return db.execute('CREATE TABLE wishlist(id INTEGER PRIMARY KEY autoincrement, description TEXT, checked INTEGER NOT NULL)');
    },
    version: 1
  );
  return db;
}

List wishlist = [];

class WishlistService {

  Future<List> load() async {
    final db = await _getDatabase();
    final data = await db.query('wishlist');
    final list = data.map((row){
      return WishItem(
        id: row['id'] as int, 
        description: row['description'] as String, 
        checked: row['checked'] as int
      );
    }).toList();
    wishlist = list;
    return list;
  }

  void save(String description, int checked) async {
    final newWish = WishItem(
      id: null,
      description: description,
      checked: 0,     
    );

    final db = await _getDatabase();

    db.insert('wishlist', {
      'description': newWish.description,
      'checked': newWish.checked, 
    });
  }

  void update(id, value) async {
    final db = await _getDatabase();
    db.update('wishlist', {'checked': value}, where: 'id = $id');
  }

  void delete(id) async {
    final db = await _getDatabase();
    db.delete('wishlist', where: 'id = $id');
  }

}