import 'package:app_videos/views/FiltroView.dart';
import 'package:app_videos/views/InfoVideoSemAtualizar.dart';
import 'package:app_videos/views/LoginView.dart';
import 'package:flutter/material.dart';
import '../models/Video.dart';
import 'MeusVideosView.dart';

class MenuInicialFiltro extends StatefulWidget {
  final int id;
  final Future<List<Video>> videosFiltrados;

  const MenuInicialFiltro({Key? key, required this.id, required this.videosFiltrados}) : super(key: key);

  @override
  _MenuInicialFiltroState createState() => _MenuInicialFiltroState(id, videosFiltrados);
}

class _MenuInicialFiltroState extends State<MenuInicialFiltro> {

  int? userid;
  Future<List<Video>>? videosFiltrados;

  _MenuInicialFiltroState(int iduser, Future<List<Video>> videosFiltrados){
    userid = iduser;
    this.videosFiltrados = videosFiltrados;
  }

  Future<List<Video>>? getVideos(){
    return videosFiltrados;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121921),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home"),
        backgroundColor: Colors.black26,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 2),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Filtro(id: userid!)),
                );
              },
              child: Text("Categorias ↓",
                style: TextStyle(
                    fontSize: 19
                ),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
              ),
            ),
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Meus Vídeos'),
                  value: 'Meus Vídeos',
                ),
                PopupMenuItem(
                  child: Text('Deslogar'),
                  value: 'Deslogar',
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'Meus Vídeos') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MeusVideos(iduser: userid)),
                );
              } else if (value == 'Deslogar') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login(

                  )),
                );              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getVideos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> videos = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Clique na imagem para mais informações!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10
                      )),
                  Padding(padding: EdgeInsets.only(top: 50)),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: videos.length,
                    separatorBuilder: (context, index) => SizedBox(height: 24),
                    itemBuilder: (context, index) {
                      Video video = videos.elementAt(index);
                      print(video.name);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => InfoVideoSemAtualizar(video: video)),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF121921),
                          ),
                          child: Column(
                            children: [
                              Text(video.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                  )),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                width: 350,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(video.thumbnailImageId),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Nenhum filme disponível'));
          }
        },
      ),
    );
  }
}
