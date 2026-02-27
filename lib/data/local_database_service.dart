import 'package:onyx_restaurant/data/models/restaurant.dart';
import 'package:onyx_restaurant/data/models/restaurant_list_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabaseService {
  static const String _databaseName = 'onyx_restaurant.db';
  static const String _tableName = 'restaurants';
  static const int _version = 1;

  static const String _columnId = 'id';
  static const String _columnName = 'name';
  static const String _columnDescription = 'description';
  static const String _columnCity = 'city';
  static const String _columnPictureId = 'pictureId';
  static const String _columnRating = 'rating';

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(path, version: _version, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        $_columnId TEXT PRIMARY KEY,
        $_columnName TEXT NOT NULL,
        $_columnDescription TEXT NOT NULL,
        $_columnCity TEXT NOT NULL,
        $_columnPictureId TEXT NOT NULL,
        $_columnRating REAL NOT NULL
      )
    ''');
  }

  Future<int> insertRestaurant(RestaurantListItem restaurant) async {
    final db = await database;

    final data = restaurant.toMap();
    final id = await db.insert(_tableName, data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<RestaurantListItem>> getAllRestaurants() async {
    final db = await database;
    final results = await db.query(_tableName);

    return results.map((result) => RestaurantListItem.fromMap(result)).toList();
  }

  Future<RestaurantListItem?> getRestaurantById(String id) async {
    final db = await database;
    final results = await db.query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);

    return results.isEmpty ? null : RestaurantListItem.fromMap(results.first);
  }

  Future<int> updateRestaurant(RestaurantListItem restaurant) async {
    final db = await database;

    final result = await db.update(
      _tableName,
      restaurant.toMap(),
      where: "id = ?",
      whereArgs: [restaurant.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<int> deleteRestaurant(String id) async {
    final db = await database;

    final result = await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
    return result;
  }
}
