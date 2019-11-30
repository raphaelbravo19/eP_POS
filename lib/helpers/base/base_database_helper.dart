import 'database_contract.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class BaseDbHelper {
  DatabaseContract contract;
  Database _db;




  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, contract.getDatabaseName());
    var theDb = await openDatabase(path,
        version: contract.getVersion(),
        onCreate: _onCreate,
        onUpgrade: _onUpgrade);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    for (int index = 0; index < contract.getCreateQueries().length; index++) {
      await db.execute(contract.getCreateQueries()[index]);
    }
    print("Created tables");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // When creating the db, create the table
    for (int index = 0; index < contract.getCreateQueries().length; index++) {
      await db.execute(contract.getCreateQueries()[index]);
    }
    print("Created tables");
  }
}
