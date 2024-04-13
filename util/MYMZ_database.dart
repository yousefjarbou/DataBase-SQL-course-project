import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../util/bus.dart';
import '../util/driver.dart';
import '../util/ticket.dart';
import '../util/route.dart';
import '../util/user.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'MYMZ.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    //bus
    await db.execute('''
    CREATE TABLE BUS (
      Bid INTEGER PRIMARY KEY,
      BusNumber TEXT
    )
    ''');

    //users
    await db.execute('''
    CREATE TABLE USERS (
      PID INTEGER PRIMARY KEY,
      FNAME TEXT,
      LNAME TEXT,
      PASSWORD TEXT,
      MOBILE_NO TEXT
    )
    ''');

    //driver
    await db.execute('''
    CREATE TABLE DRIVER(
      id INTEGER PRIMARY KEY,
      License_no TEXT NOT NULL,
      FNAME TEXT,
      LNAME TEXT,
      Bid TEXT
    )
    ''');

    //rout
    await db.execute('''
    CREATE TABLE ROUTE (
      Rid INTEGER NOT NULL,
      Pickup_point TEXT NOT NULL,
      Arrival_point TEXT NOT NULL,
      PRIMARY KEY (Rid)
    )
    ''');

    //ticket
    await db.execute('''
    CREATE TABLE TICKET (
      Tid INTEGER  PRIMARY KEY,
      Expiry_date TEXT NOT NULL,
      Status TEXT NOT NULL,
      Departure_time TEXT NOT NULL,
      Price TEXT NOT NULL,
      Vip TEXT NOT NULL,
      Bid TEXT NOT NULL
    )
    ''');


  }

  Future<List<BUS>> getBusses() async {
    Database db = await instance.database;
    var names = await db.query('BUS', orderBy: 'BusNumber');
    List<BUS> nameList = names.isNotEmpty
        ? names.map((c) => BUS.fromMap(c)).toList()
        : [];
    return nameList;
  }

  Future<int> addBusses(BUS bus) async {
    Database db = await instance.database;
    return await db.insert('BUS', bus.toMap());
  }

  Future<int> removebusses(int id) async {
    Database db = await instance.database;
    return await db.delete('BUS', where: 'Bid = ?', whereArgs: [id]);
  }

  Future<int> updatebusses(BUS bus) async {
    Database db = await instance.database;
    var data = await db.update(
        'BUS', bus.toMap(), where: 'BusNumber = ?', whereArgs: [bus.BusNumber]);
    return data;
  }

  Future<List<BUS>> getBusbynum(String name) async {
    Database db = await instance.database;
    var names = await db.query(
        'BUS', where: 'BusNumber = ?', whereArgs: [name]);
    List<BUS> nameList = names.isNotEmpty
        ? names.map((c) => BUS.fromMap(c)).toList()
        : [];
    return nameList;
  }

  // Future<List<Bus>> getByID(int id) async {
  //   Database db = await instance.database;
  //   var busses = await db.query('BUS', where: 'Bid = ?', whereArgs: [id]);
  //   List<Bus> nameList = busses.isNotEmpty
  //       ? busses.map((c) => Bus.fromMap(c)).toList()
  //       : [];
  //   return nameList;
  // }


///////////
///////////
//users
  Future<List<USERS>> getUsers() async {
    Database db = await instance.database;
    var names = await db.query('USERS', orderBy: 'FNAME');
    List<USERS> nameList = names.isNotEmpty
        ? names.map((c) => USERS.fromMap(c)).toList()
        : [];
    return nameList;
  }

  Future<int> addUsers(USERS users) async {
    Database db = await instance.database;
    return await db.insert('USERS', users.toMap());
  }


/////
////
//driver
  Future<List<DRIVER>> getDRIVERs() async {
    Database db = await instance.database;
    var names = await db.query('DRIVER', orderBy: 'FNAME');
    List<DRIVER> nameList = names.isNotEmpty
        ? names.map((c) => DRIVER.fromMap(c)).toList()
        : [];
    return nameList;
  }

  Future<int> addDriver(DRIVER driver) async {
    Database db = await instance.database;
    return await db.insert('DRIVER', driver.toMap());
  }

/////
////
//rout
  Future<List<ROUTE>> getROUTEs() async {
    Database db = await instance.database;
    var names = await db.query('ROUTE', orderBy: 'Rid');
    List<ROUTE> nameList = names.isNotEmpty
        ? names.map((c) => ROUTE.fromMap(c)).toList()
        : [];
    return nameList;
  }

  Future<int> addROUTE(ROUTE routes) async {
    Database db = await instance.database;
    return await db.insert('ROUTE', routes.toMap());
  }

  Future<List<ROUTE>> getRoutByPickup(String name) async {
    Database db = await instance.database;
    var names = await db.query(
        'ROUTE', where: 'Pickup_point = ?', whereArgs: [name]);
    List<ROUTE> nameList = names.isNotEmpty
        ? names.map((c) => ROUTE.fromMap(c)).toList()
        : [];
    return nameList;
  }

  Future<List<ROUTE>> getRoutByArrive(String name) async {
    Database db = await instance.database;
    var names = await db.query(
        'ROUTE', where: 'Arrival_point = ?', whereArgs: [name]);
    List<ROUTE> nameList = names.isNotEmpty
        ? names.map((c) => ROUTE.fromMap(c)).toList()
        : [];
    return nameList;
  }
/////
/////
//ticket
  Future<List<TICKET>> getTickets() async {
    Database db = await instance.database;
    var names = await db.query('TICKET', orderBy: 'Tid');
    List<TICKET> nameList = names.isNotEmpty
        ? names.map((c) => TICKET.fromMap(c)).toList()
        : [];
    return nameList;
  }

  Future<int> addTicket(TICKET ticket) async {
    Database db = await instance.database;
    return await db.insert('TICKET', ticket.toMap());
  }

}