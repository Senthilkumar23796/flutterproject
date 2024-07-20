import 'package:demofood/jsonModels/users.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final dataBaseName = "users.db";
  //String userTable = "CREATE TABLE users(usrId INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL,email TEXT NOT NULL,mobile BIGINT NOT NULL,password VARTEXT NOT NULL,createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";
  String userTable="create table users(usrId INTEGER PRIMARY KEY AUTOINCREMENT,usrName TEXT,usrEmail TEXT,usrMobile VARTEXT,usrPassword VARTEXT,createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dataBaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(userTable);
    });
  }

  //LOGIN METHOD
  Future<bool> login(Users user) async{
    final Database db=await initDB();
    var result=await db.rawQuery(
        "select * from users where usrEmail='${user.usrEmail}' AND usrPassword='${user.usrPassword}'");
    //print(result);
    if(result.isNotEmpty){
      return true;
    }
    else{
      return false;
    }
  }
  //SIGNUP
  Future<int> signUp(Users user) async{
    final Database db=await initDB();
    return db.insert('users', user.toMap());
  }
  //Get Method

  //CRUD METHODS

  //CREATE USER
  Future<int> createUser(Users user) async {
    final Database db = await initDB();
    return db.insert('users', user.toMap());
  }

  //GET USER
  Future<Users?> getUser(String usrEmail) async {
    final Database db = await initDB();
    var res=await db.query("users",where: "usrEmail=?",whereArgs: [usrEmail]);
    return res.isNotEmpty? Users.fromMap(res.first):null;
  }
//DELETE USER
Future<int> deleteUser(int id) async{
    final Database db=await initDB();
    return db.delete('users',where: 'usrId=?',whereArgs: [id]);
}
//UPDATE USER
Future<int> updateUser(int id) async{
    final Database db=await initDB();
    return db.rawUpdate('update users set usrPassword=? where useId=?',[]);
}
}
