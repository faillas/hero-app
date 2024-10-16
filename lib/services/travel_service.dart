import 'dart:typed_data';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:test_drive/models/budget.dart';
import 'package:test_drive/models/cover.dart';
import 'package:test_drive/models/plan.dart';
import 'package:test_drive/models/travel.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'travels.db'), 
    onCreate: (db, version) async {
      await db.execute(
        '''
          CREATE TABLE travels(
            id INTEGER PRIMARY KEY autoincrement, 
            name TEXT, 
            date_start TEXT,
            date_end TEXT,
            image BLOB DEFAULT NULL,
            notes TEXT
          )
        '''
      );
      await db.execute(
        '''
        CREATE TABLE images(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          travel_id INTEGER,
          image BLOB NOT NULL,
          extension TEXT NOT NULL,
          FOREIGN KEY(travel_id) REFERENCES travels(id) ON DELETE CASCADE
        )
        '''
      );
      await db.execute(
        '''
        CREATE TABLE budgets(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          travel_id INTEGER, 
          name TEXT, 
          estimate TEXT, 
          price TEXT,
          created_at TEXT,
          FOREIGN KEY(travel_id) REFERENCES travels(id) ON DELETE CASCADE
        )
        '''
      );
      await db.execute(
        '''
        CREATE TABLE plans(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          travel_id INTEGER, 
          date TEXT, 
          hour_start TEXT, 
          description TEXT,
          category TEXT,
          FOREIGN KEY(travel_id) REFERENCES travels(id) ON DELETE CASCADE
        )
        '''
      );
    },
    version: 1
  );
  return db;
}

List _budgets = [];
List _plans = [];

class TravelService {

  Future<List> loadTravels() async {
    final db = await _getDatabase();
    final data = await db.query('travels');
    final dataTravels = data.map((row){
      return Travel(
        id: row['id'] as int, 
        name: row['name'] as String, 
        image: row['image'] as Uint8List?, 
        dateStart: row['date_start'] as String,
        dateEnd: row['date_end'] as String,
        notes: row['notes'] as String,
      );
    }).toList();
    return dataTravels;
  }

  Future<List<Budget>> loadBudgets(travelId) async {
    final db = await _getDatabase();
    final data = await db.query('budgets',  where: 'travel_id = $travelId');
    final dataBudgets = data.map((row){
      return Budget(
        id: row['id'] as int, 
        travelId: row['travel_id'] as int,
        name: row['name'] as String, 
        estimate: row['estimate'] as String, 
        value: row['price'] as String,
        createdAt: row['created_at'] != null? row['created_at'] as String : '',
      );
    }).toList();
    _budgets = dataBudgets;
    return dataBudgets;
  }

  Future<List<Map<String, Object?>>> getTravelsCosts() async {
    final db = await _getDatabase();
    final data = await db.rawQuery('''
      SELECT 
        t.id AS travel_id, 
        t.name AS travel_name, 
        SUM(CAST(b.price AS REAL)) AS total_price,
        SUM(CAST(b.estimate AS REAL)) AS total_estimate
      FROM travels t
      LEFT JOIN budgets b 
        ON t.id = b.travel_id
      GROUP BY t.id
    ''');    
    return data;
  }

  Future<List<Map<String, Object?>>> getCurrentYearCosts() async {
    final db = await _getDatabase();
    final data = await db.rawQuery('''
      SELECT 
        t.id AS travel_id, 
        t.name AS travel_name, 
        SUM(CAST(b.price AS REAL)) AS total_price,
        SUM(CAST(b.estimate AS REAL)) AS total_estimate,
        substr(t.date_start, 7, 4) AS travel_year
      FROM travels t
      LEFT JOIN budgets b 
        ON t.id = b.travel_id
      WHERE substr(t.date_start, 7, 4) = strftime('%Y', 'now')
      GROUP BY t.id
    ''');    
    return data;
  }

  Future<List<Plan>> loadPlans(travelId) async {
    final db = await _getDatabase();
    final data = await db.query('plans', 
      where: 'travel_id = $travelId',  
      orderBy: 'date ASC, hour_start ASC'
    );
    final dataPlans = data.map((row){
      return Plan(
        id: row['id'] as int, 
        travelId: row['travel_id'] as int, 
        date: row['date'] as String, 
        hourStart: row['hour_start'] as String,
        description: row['description'] as String,
        category: row['category'] as String?
      );
    }).toList();
    _plans = dataPlans;
    return dataPlans;
  }

  Future<List<Plan>> getAllPlans() async {
    final db = await _getDatabase();
    final data = await db.query('plans');
    final dataPlans = data.map((row){
      return Plan(
        id: row['id'] as int, 
        travelId: row['travel_id'] as int, 
        date: row['date'] as String, 
        hourStart: row['hour_start'] as String,
        description: row['description'] as String,
        category: row['category'] as String?
      );
    }).toList();
    _plans = dataPlans;
    return dataPlans;
  }

  Future<dynamic> find(id) async {
    final db = await _getDatabase();
    final data = await db.query('travels', where: 'id = $id');
    final dataTravel = data.map((row){
      return Plan(
        id: row['id'] as int, 
        travelId: row['travel_id'] as int, 
        date: row['date'] as String, 
        hourStart: row['hour_start'] as String,
        description: row['description'] as String,
        category: row['category'] as String
      );
    }).toList();
    await loadBudgets(id);
    await loadPlans(id);

    final result = {
      'travel': dataTravel,
      'budgets': _budgets,
      'plans': _plans,
    };

    return result;
  }

  void save(Travel travel, List<Budget> budgets, List<Plan> plans, Cover cover) async{
    final db = await _getDatabase();

    final id = await db.insert('travels', {
      'id': null,
      'name': travel.name,
      'image':travel.image,
      'date_start':travel.dateStart,
      'date_end':travel.dateEnd,
      'notes':travel.notes
    });

    db.insert('images', {
      'id':null,
      'travel_id': id,
      'image': cover.image,
      'extension': cover.extension,
    });

    for (var i = 0; i < budgets.length; i++) {
      db.insert('budgets', {
        'id':null,
        'travel_id': id,
        'name': budgets[i].name,
        'estimate': budgets[i].estimate,
        'price': budgets[i].value,
      });
    }

    for (var i = 0; i < plans.length; i++) {
      db.insert('plans', {
        'id':null,
        'travel_id': id,
        'date': plans[i].date,
        'hour_start': plans[i].hourStart,
        'description': plans[i].description, 
        'category': plans[i].category,
      });
    }
  }

  Future<void> update(Travel travel, List<Budget> budgets, List<Plan> plans, List<Budget> deletedBudgets, List<Plan> deletedPlans, Cover cover) async {
    final db = await _getDatabase();

    db.update('travels', {
      'name': travel.name,
      'image': travel.image,
      'date_start':travel.dateStart,
      'date_end':travel.dateEnd,
      'notes':travel.notes
    }, where: 'id = ${travel.id}');

    for (var i = 0; i < deletedBudgets.length; i++) {
      db.delete('budgets', where: 'id = ${deletedBudgets[i].id}'); 
    }
    for (var i = 0; i < deletedPlans.length; i++) {  
      db.delete('plans', where: 'id = ${deletedPlans[i].id}'); 
    }

    for (var i = 0; i < budgets.length; i++) {  
      db.insert('budgets', {
        'travel_id': travel.id,
        'name': budgets[i].name,
        'estimate': budgets[i].estimate,
        'price': budgets[i].value,
      });     
    }

    for (var i = 0; i < plans.length; i++) {
      db.insert('plans', {
        'travel_id': travel.id,
        'date': plans[i].date,
        'hour_start': plans[i].hourStart,
        'description': plans[i].description, 
        'category': plans[i].category,
      });
    }
  }

  void deleteTravel(id) async {
    final db = await _getDatabase();
    db.delete('travels', where: 'id = $id');
  }

  Future<int> saveTravel(Travel travel) async {
    final db = await _getDatabase();
    return await db.insert('travels', {
      'id': null,
      'name': travel.name,
      'image':travel.image,
      'date_start':travel.dateStart,
      'date_end':travel.dateEnd,
      'notes':travel.notes
    });
  }

  void updateTravel(Travel travel) async {
    final db = await _getDatabase();
    final id = travel.id;
    db.update('travels', {
      'name': travel.name,
      'image':travel.image,
      'dateStart':travel.dateStart,
      'dateEnd':travel.dateEnd,
      'notes':travel.notes
    }, where: 'id = $id');
  }

  void saveBudget(Budget budget, Travel? travel) async {
    final db = await _getDatabase();
    if(travel != null){
      db.insert('budgets', {
        'id':null,
        'travel_id': travel.id,
        'name': budget.name,
        'estimate': budget.estimate,
        'price': budget.value,
      });
    }else{
      db.insert('budgets', {
        'id':null,
        'travel_id': budget.travelId,
        'name': budget.name,
        'estimate': budget.estimate,
        'price': budget.value,
      });
    }   
  }

  void updateBudget(Budget budget) async {
    final db = await _getDatabase();
    final id = budget.id;
    db.update('budgets', {
      'travel_id': budget.travelId,
      'name': budget.name,
      'estimate': budget.estimate,
      'price': budget.value,
    }, where: 'id = $id');
  }

  void deleteBudget(id) async {
    final db = await _getDatabase();
    db.delete('budgets', where: 'id = $id');
  }

  void savePlan(Plan plan, Travel? travel) async {
    final db = await _getDatabase();
    if(travel != null){
      db.insert('plans', {
        'id':null,
        'travel_id': travel.id,
        'date': plan.date,
        'hour_start': plan.hourStart,
        'description': plan.description, 
        'category': plan.category, 
      });

    }else{
      db.insert('plans', {
        'id':null,
        'travel_id': plan.travelId,
        'date': plan.date,
        'hour_start': plan.hourStart,
        'description': plan.description, 
        'category': plan.category,
      });
    } 
  }

  void updatePlan(Plan plan) async {
    final db = await _getDatabase();
    final id = plan.id;
    db.update('plans', {
      'travel_id': plan.travelId,
      'date': plan.date,
      'hour_start': plan.hourStart,
      'description': plan.description, 
      'category': plan.category,
    }, where: 'id = $id');
  }

  void deletePlan(id) async {
    final db = await _getDatabase();
    db.delete('plans', where: 'id = $id');
  }

}
