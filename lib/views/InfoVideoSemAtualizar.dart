import 'package:app_videos/views/AtualizarVideoView.dart';
import 'package:flutter/material.dart';
import '../DAO/GenreDAO.dart';
import '../models/Genre.dart';
import '../models/Video.dart';

class InfoVideoSemAtualizar extends StatefulWidget {
  final Video video;

  const InfoVideoSemAtualizar({Key? key, required this.video}) : super(key: key);

  @override
  State<InfoVideoSemAtualizar> createState() => _InfoVideoSemAtualizarState(video);
}

class _InfoVideoSemAtualizarState extends State<InfoVideoSemAtualizar> {

  _InfoVideoSemAtualizarState(Video video){
    this.video = video;

  }

  Video? video;
  Future<List<Genre>>? generosFuture;


  @override
  void initState() {
    super.initState();
    generosFuture = GenreDAO().SelectGenres(video!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121921),
      appBar: AppBar(
        title: Text("Detalhes"),
        backgroundColor: Colors.black26,
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                    video!.thumbnailImageId,
                    width: 180,
                    height: 300
                ),
                Padding(padding: EdgeInsets.only(left: 3)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Lançamento: ${video!.releaseDate}",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    Text("Classificação Etária: ${video!.ageRestriction}",
                      style: TextStyle(
                          color: Colors.white
                      ),),
                    Text("Duração: ${video!.durationMinutes} minutos",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    FutureBuilder<List<Genre>>(
                      future: generosFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erro ao carregar os gêneros');
                        } else if (snapshot.hasData) {
                          List<Genre> generos = snapshot.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: generos.map((genre) => Text(
                              genre.name,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )).toList(),
                          );
                        } else {
                          return Text('');
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(padding: EdgeInsets.only(top: 50)),
                Expanded(
                    child: Text(video!.description,
                      style: TextStyle(
                          color: Colors.white
                      ),)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
