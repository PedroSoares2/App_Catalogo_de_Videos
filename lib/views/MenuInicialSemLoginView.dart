import 'package:app_videos/DAO/VideoDAO.dart';
import 'package:app_videos/views/CadastroView.dart';
import 'package:app_videos/views/FiltroView.dart';
import 'package:app_videos/views/InfoVideoView.dart';
import 'package:app_videos/views/LoginView.dart';
import 'package:flutter/material.dart';
import '../models/Video.dart';
import 'InfoVideoSemAtualizar.dart';

class MenuInicialSemLogin extends StatefulWidget {
  const MenuInicialSemLogin({Key? key});

  @override
  State<MenuInicialSemLogin> createState() => _MenuInicialSemLoginState();
}

class _MenuInicialSemLoginState extends State<MenuInicialSemLogin> {
  Future<List<Video>> getVideos() {
    VideoDAO videoDAO = VideoDAO();
    return videoDAO.list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121921),
      appBar: AppBar(title: const Text("Home"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 2),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Filtro(id: 1000)),
                );
              },
              child: Text("Categorias ↓",
              style: TextStyle(
                fontSize: 18
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
                  child: Text('Logar'),
                  value: 'Logar',
                ),
                PopupMenuItem(
                  child: Text('Cadastrar'),
                  value: 'Cadastrar',
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'Logar') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              } else if (value == 'Cadastrar') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroView()),
                );              }
            },
          ),
        ],
      backgroundColor: Colors.black26,),
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
