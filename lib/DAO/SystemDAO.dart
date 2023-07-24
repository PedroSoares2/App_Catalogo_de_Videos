import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SystemDAO {

  static recoverDataBase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "banco.db");

    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {

        String createTableUserSql = '''
        CREATE TABLE user(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name VARCHAR NOT NULL,
          email VARCHAR NOT NULL,
          password VARCHAR NOT NULL
        );
      ''';

        String createTableVideoSql = '''
        CREATE TABLE video(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name VARCHAR(2) NOT NULL,
          description TEXT NOT NULL,
          type INTEGER NOT NULL,
          ageRestriction VARCHAR NOT NULL,
          durationMinutes INTEGER NOT NULL,
          thumbnailImageId VARCHAR NOT NULL,
          releaseDate TEXT NOT NULL,
          userid INTEGER NOT NULL,
          FOREIGN KEY(userid) REFERENCES user(id)
        );
      ''';

        String createTableGenreSql = '''
        CREATE TABLE genre(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name VARCHAR NOT NULL
        );
      ''';

        String createTableVideoGenreSql = '''
        CREATE TABLE video_genre(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          videoid INTEGER NOT NULL,
          genreid INTEGER NOT NULL,
          FOREIGN KEY(videoid) REFERENCES video(id),
          FOREIGN KEY(genreid) REFERENCES genre(id)
        );
      ''';

        await db.execute(createTableUserSql);
        await db.execute(createTableVideoSql);
        await db.execute(createTableGenreSql);
        await db.execute(createTableVideoGenreSql);
      },
    );

    return db;
  }
}