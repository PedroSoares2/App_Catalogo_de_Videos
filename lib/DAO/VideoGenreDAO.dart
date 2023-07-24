import 'package:sqflite/sqflite.dart';
import 'SystemDAO.dart';

class VideoGenreDAO {

  saveVideoGenre(int id1, int id2) async{

    Database db = await SystemDAO.recoverDataBase();

    Map<String, dynamic> values = {
      'videoid': id1,
      'genreid': id2,
    };

    int result = await db.insert('video_genre', values);
  }

  deleteById(int id) async {
    Database db = await SystemDAO.recoverDataBase();

    int response = await db.delete(
      "video_genre",
      where: "videoid=?",
      whereArgs: [id],
    );
  }

}