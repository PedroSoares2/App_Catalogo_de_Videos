import 'package:app_videos/DAO/SystemDAO.dart';
import 'package:sqflite/sqflite.dart';
import '../models/Video.dart';

class VideoDAO {

  Future<int> saveVideo(Video video1) async {
    Database db = await SystemDAO.recoverDataBase();

    Map<String, dynamic> video = {
      "name": video1.name,
      "description": video1.description,
      "type": video1.type,
      "ageRestriction": video1.ageRestriction,
      "durationMinutes": video1.durationMinutes,
      "thumbnailImageId": video1.thumbnailImageId,
      "releaseDate": video1.releaseDate,
      "userid": video1.idUser
    };

    int id = await db.insert("video", video);
    return id;
  }

  Future<List<Video>> list() async {
    Database db = await SystemDAO.recoverDataBase();

    String sql = "SELECT * FROM video";
    List<Map<String, dynamic>> results = await db.rawQuery(sql);

    List<Video> videos = results.map((map) {
      return Video.withId(
        map["id"],
        map["name"],
        map["description"],
        map["type"],
        map["ageRestriction"],
        map["durationMinutes"],
        map["thumbnailImageId"],
        map["releaseDate"],
          map["userid"]
      );
    }).toList();

    return videos;
  }

  deleteById(int id) async {
    Database db = await SystemDAO.recoverDataBase();

    int response = await db.delete(
      "video",
      where: "id=?",
      whereArgs: [id],
    );
  }

  Future<List<Video>> listById(int id) async {
    Database db = await SystemDAO.recoverDataBase();

    String sql = "SELECT * FROM video where userid = ${id}";
    List<Map<String, dynamic>> results = await db.rawQuery(sql);

    List<Video> videos = results.map((map) {
      return Video.withId(
        map["id"],
        map["name"],
        map["description"],
        map["type"],
        map["ageRestriction"],
        map["durationMinutes"],
        map["thumbnailImageId"],
        map["releaseDate"],
        map["userid"]
      );
    }).toList();
    return videos;
  }

  listByTipo(int? tipoSelecionado) async {
    Database db = await SystemDAO.recoverDataBase();

    String sql = "SELECT video.* FROM video where type = ${tipoSelecionado}";
    List<Map<String, dynamic>> results = await db.rawQuery(sql);

    List<Video> videos = results.map((map) {
      return Video.withId(
          map["id"],
          map["name"],
          map["description"],
          map["type"],
          map["ageRestriction"],
          map["durationMinutes"],
          map["thumbnailImageId"],
          map["releaseDate"],
          map["userid"]
      );
    }).toList();
    return videos;
  }

  listByTipoAndGenre(int? tipoSelecionado, String? generoSelecionado) async {
    Database db = await SystemDAO.recoverDataBase();

    String sql = "SELECT video.* FROM video,video_genre,genre where type = ${tipoSelecionado} and video.id = video_genre.videoid and video_genre.genreid = genre.id and genre.name = '${generoSelecionado}'";

    List<Map<String, dynamic>> results = await db.rawQuery(sql);

    List<Video> videos = results.map((map) {
      return Video.withId(
          map["id"],
          map["name"],
          map["description"],
          map["type"],
          map["ageRestriction"],
          map["durationMinutes"],
          map["thumbnailImageId"],
          map["releaseDate"],
          map["userid"]
      );
    }).toList();
    return videos;
  }

  listByGenre(String? generoSelecionado) async {
    Database db = await SystemDAO.recoverDataBase();

    String sql = "SELECT video.* FROM video,video_genre,genre where video.id = video_genre.videoid and video_genre.genreid = genre.id and genre.name = '${generoSelecionado}'";
    List<Map<String, dynamic>> results = await db.rawQuery(sql);

    List<Video> videos = results.map((map) {
      return Video.withId(
          map["id"],
          map["name"],
          map["description"],
          map["type"],
          map["ageRestriction"],
          map["durationMinutes"],
          map["thumbnailImageId"],
          map["releaseDate"],
          map["userid"]
      );
    }).toList();
    return videos;
  }

  void atualizarVideo(Video video1) async {
    final db = await SystemDAO.recoverDataBase();

    Map<String, dynamic> video = {
      "name": video1.name,
      "description": video1.description,
      "type": video1.type,
      "ageRestriction": video1.ageRestriction,
      "durationMinutes": video1.durationMinutes,
      "thumbnailImageId": video1.thumbnailImageId,
      "releaseDate": video1.releaseDate,
      "userid": video1.idUser
    };

    await db.update(
      'video',
      video,
      where: 'id = ?',
      whereArgs: [video1.id],
    );
  }


}



