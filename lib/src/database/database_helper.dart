import 'package:data_oson_aptek/src/model/oson_aptek_messag_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableName = 'qwertyTable';
  final String columnId = 'id';
  final String columnName = 'name';

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'ajssa.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tableName('
        '$columnName TEXT,'
        '$columnId INTEGER PRIMARY KEY');
  }

  Future<int> saveData(OsonAptekMessageModel saqla) async {
    var dbClient = await db;
    var saveResult = await dbClient.insert(
      tableName,
      saqla.toJson(),
    );
    return saveResult;
  }

  Future<List<OsonAptekMessageModel>> getData() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM $tableName');
    List<OsonAptekMessageModel> products = <OsonAptekMessageModel>[];
    for (int i = 0; i < list.length; i++) {
      OsonAptekMessageModel items = OsonAptekMessageModel(
          id: list[i][columnId], name: list[i][columnName]);
      products.add(items);
    }
    return products;
  }

  Future<int> deleteData(int idisi) async {
    var dbClient = await db;
    return await dbClient.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [idisi],
    );
  }

  Future<int> updateData(OsonAptekMessageModel yangilash) async {
    var dbClent = await db;
    return await dbClent.update(
      tableName,
      yangilash.toJson(),
      where: '$columnId = ?',
      whereArgs: [yangilash.id],
    );
  }
}
