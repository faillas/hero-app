
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:hero/models/configuration.dart';
import 'package:hero/models/theme.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'config.db'), 
    onCreate: (db, version) async {
      await db.execute(
        '''
          CREATE TABLE configurations(
            id INTEGER PRIMARY KEY autoincrement, 
            name TEXT, 
            value INTEGER NOT NULL        
          )
        '''
      );
      await db.execute(
        '''
          CREATE TABLE themes(
            id INTEGER PRIMARY KEY autoincrement, 
            name TEXT, 
            active INTEGER NOT NULL        
          )
        '''
      );
      db.insert('configurations', {
        'name': 'first_load',
        'value': 1, 
      });
       db.insert('themes', {
        'name': 'light',
        'active': 1, 
      });
      db.insert('themes', {
        'name': 'dark',
        'active': 0, 
      });
      
    },
    version: 1
  );
  return db;
}

class ConfigService {

  Future<List> getConfig() async {
    final db = await _getDatabase();
    final data = await db.query('configurations');
    final dataConfigurations = data.map((row){
      return Configuration(
        id: row['id'] as int, 
        name: row['name'] as String, 
        value: row['value'] as int, 
      );
    }).toList();
    return dataConfigurations;
  }

  Future<List> loadThemes() async {
    final db = await _getDatabase();
    final data = await db.query('themes');
    final dataThemes = data.map((row){
      return Tema(
        id: row['id'] as int, 
        name: row['name'] as String, 
        active: row['active'] as int, 
      );
    }).toList();
    return dataThemes;
  }

  Future<dynamic> findTheme(id) async {
    final db = await _getDatabase();
    final data = await db.query('themes', where: 'id = $id');
    final tema = data.map((row){
      return Tema(
        id: row['id'] as int, 
        name: row['name'] as String, 
        active: row['active'] as int,   
      );
    }).toList();

    return tema;
  }

  Future<dynamic> findActiveTheme() async {
    final db = await _getDatabase();
    final data = await db.query('themes', where: 'active = 1');
    final tema = data.map((row){
      return Tema(
        id: row['id'] as int, 
        name: row['name'] as String, 
        active: row['active'] as int,   
      );
    }).first;
    return tema;
  }

  Future<int> findConfig(name) async {
    final db = await _getDatabase();
    final data = await db.query('configurations', where: 'name = $name');
    final configurationData = data.map((row){
      return row['value'] as int;
      
    }).first;

    return configurationData;
  }

  void updateTheme(id) async {
    final db = await _getDatabase();
    db.update('themes', {'active': 0}, where: 'active = 1');
    db.update('themes', {'active': 1}, where: 'id = $id');
  }

  void updateConfig(id, value) async {
    final db = await _getDatabase();
    db.update('configurations', {'value': value}, where: 'id = $id');
  }

  

}