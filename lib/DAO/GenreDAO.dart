import 'package:app_videos/DAO/SystemDAO.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Genre.dart';
import '../models/User.dart';
import '../models/Video.dart';

class GenreDAO {

  saveGenres() async {
    Database db = await SystemDAO.recoverDataBase();

    int? count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM genre'));

    if (count == 0) {
      String insertGenresSql = """
        INSERT INTO genre (name) VALUES
          ('Comédia'),
          ('Terror'),
          ('Aventura'),
          ('Ação'),
          ('Suspense'),
          ('Drama');
        """;
      await db.execute(insertGenresSql);
    }
}

  Future<List<Genre>> list() async {
    Database db = await SystemDAO.recoverDataBase();

    String sql = "SELECT * FROM genre";
    List<Map<String, dynamic>> results = await db.rawQuery(sql);

    List<Genre> genres = results.map((map) {
      return Genre.withId(
        map["id"],
        map["name"],
      );
    }).toList();

    return genres;
  }

  Future<int?> findIdByName(String genero) async {
    Database db = await SystemDAO.recoverDataBase();

    List<Map<String, dynamic>> rows = await db.query(
      "genre",
      columns: ["id"],
      where: "name = ?",
      whereArgs: [genero],
      limit: 1,
    );

    if (rows.isNotEmpty) {
      print(rows.first["id"] as int);
      return rows.first["id"] as int;
    }
    return null;
  }

  Future<List<Genre>> SelectGenres(Video video) async {
      Database db = await SystemDAO.recoverDataBase();

      String sql = "SELECT distinct genre.* FROM video,video_genre,genre where video.id = ${video.id} and video_genre.videoid = ${video.id} and video_genre.genreid = genre.id";
      List<Map<String, dynamic>> results = await db.rawQuery(sql);

      List<Genre> genres = results.map((map) {
      return Genre.withId(
        map["id"],
        map["name"],
        );
        }).toList();
      return genres;
  }

}

