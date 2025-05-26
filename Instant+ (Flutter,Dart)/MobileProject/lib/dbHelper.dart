import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Classes/user_info.dart'; // Import your UserInfo class

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'user_info.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE user_info (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            firstName TEXT NOT NULL,
            lastName TEXT NOT NULL,
            phoneNumber TEXT NOT NULL,
            email TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> saveUser(UserInfo user) async {
    final db = await database;
    return await db.insert('user_info', {
      'firstName': user.getFirstName(),
      'lastName': user.getLastName(),
      'phoneNumber': user.getPhoneNumber(),
      'email': user.getEmail(),
    });
  }

  Future<UserInfo?> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('user_info', limit: 1);

    if (result.isNotEmpty) {
      final userMap = result.first;
      return UserInfo.parameterized(
        firstName: userMap['firstName'],
        lastName: userMap['lastName'],
        phoneNumber: userMap['phoneNumber'],
        email: userMap['email'],
        profileImage: Image.asset('assets/temporary/profile_picture.png'), // Default profile image
        paymentMethods: [],
      );
    }
    return null;
  }

  Future<void> updateUserInfo(UserInfo userInfo) async {
    final db = await database; // Assumes a `database` getter for your SQLite instance

    await db.update(
      'user_info', // Replace with your table name
      {
        'first_name': userInfo.getFirstName(),
        'last_name': userInfo.getLastName(),
        'phone_number': userInfo.getPhoneNumber(),
        'email': userInfo.getEmail(), // Save the image path if applicable
      },
      where: 'id = ?', // Adjust the condition based on your table schema
      whereArgs: [userInfo.id], // Ensure `UserInfo` has an `id` property
    );
  }
}