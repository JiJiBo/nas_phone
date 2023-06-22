import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> _creatDb() async {
//获取数据库路径
  String _createTableSQL =
      'CREATE TABLE local_address (id INTEGER PRIMARY KEY, name TEXT, phone TEXT,ext TEXT,create_time BIGINT)';

  return await openDatabase(await getPath(),
      version: 1,
      onUpgrade: (Database db, int oldVersion, int newVersion) async {},
      onCreate: (Database db, int vers) async {
    //创建表，只回调一次
    await db.execute(_createTableSQL);
  });
}

Future<String> getPath() async {
  /// 适配window，不允许删除
  String databasesPath;

  databasesPath = await getDatabasesPath();

  String path = join(databasesPath, "local_address");
  return path;
}

Future<void> addLocalData(String name, String phone,
    {String? ext = "ext"}) async {
  var db = await _creatDb();

  await db.execute(
      "INSERT INTO local_address(name,phone,ext,create_time)VALUES('$name','$phone','$ext',' ${DateTime.now().millisecondsSinceEpoch}')");
  await db.close();
}

Future<void> delLocalData(int id) async {
  var db = await _creatDb();
  await db.execute("delete from local_address where id=${id}");
  await db.close();
}

Future<void> delLocalDataByName(String name) async {
  var db = await _creatDb();
  await db.execute("delete from local_address where name='${name}'");
  await db.close();
}

Future<void> delLocalDataByExt(String ext) async {
  var db = await _creatDb();
  await db.execute("delete from local_address where ext='${ext}'");
  await db.close();
}

Future<void> delLocalDataByPhone(String phone) async {
  var db = await _creatDb();
  await db.execute("delete from local_address where phone='${phone}'");
  await db.close();
}

Future<List<Map>> getLocalAllData() async {
  var db = await _creatDb();
  List<Map> list = await db
      .rawQuery("SELECT * FROM local_address order by create_time desc");
  await db.close();
  return list;
}

Future<List<Map>> getLocalAllDataByPage(int page) async {
  var db = await _creatDb();
  List<Map> list = await db.rawQuery(
      "SELECT * FROM local_address order by create_time desc limit 10 offset ${page * 10}");
  await db.close();
  return list;
}

Future<List<Map>> getAPhoneLocalData(String name) async {
  var db = await _creatDb();
  List<Map> list = await db.rawQuery(
      "SELECT * FROM local_address where name= ?  order by create_time desc",
      [name.replaceAll(" ", "")]);
  await db.close();
  return list;
}

Future<List<Map>> getAllShrinkLocalData() async {
  List<Map> allData = await getLocalAllData();
  Map<String, Map> shrinkData = {};
  for (var value in allData) {
    shrinkData.putIfAbsent(value["name"], () => value);
  }
  return shrinkData.values.toList();
}
