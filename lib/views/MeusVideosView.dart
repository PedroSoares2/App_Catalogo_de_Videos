import 'package:app_videos/DAO/UserDAO.dart';
import 'package:app_videos/views/CadastroVideoView.dart';
import 'package:app_videos/views/InfoVideoView.dart';
import 'package:app_videos/views/MenuInicialView.dart';
import 'package:flutter/material.dart';

import '../DAO/VideoDAO.dart';
import '../models/User.dart';
import '../models/Video.dart';
import 'CadastroView.dart';

class MeusVideos extends StatefulWidget {
  final int? iduser;

  const MeusVideos({Key? key, required this.iduser}) : super(key: key);

  @override
  _MeusVideosState createState() => _MeusVideosState(iduser!);
}

class _MeusVideosState extends State<MeusVideos> {
  Future<List<Video>> getVideos() {
    VideoDAO videoDAO = VideoDAO();
    return videoDAO.listById(userid!);
  }

  int? userid;

  _MeusVideosState(int iduser){
      userid = iduser;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121921),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Meus Videos"),
        backgroundColor: Colors.black26,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuInicial(iduser: userid!,))
                );
              },
              child: Text("Voltar",
                style: TextStyle(
                    fontSize: 18
                ),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroVideo(iduser: userid))
                );
              },
              child: Text("Adicionar",
              style: TextStyle(
                fontSize: 18
              ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
              ),
            ),
          ),
        ],
       ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FutureBuilder<List<dynamic>>(
              future: getVideos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<dynamic> videos = snapshot.data!;
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 50)),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: videos.length,
                          separatorBuilder: (context, index) => SizedBox(height: 24),
                          itemBuilder: (context, index) {
                            Video video = videos.elementAt(index);
                            return Dismissible(
                              key: Key(video.id.toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (direction) {
                                VideoDAO videodao = VideoDAO();
                                videodao.deleteById(video.id!);
                              },
                              child: SingleChildScrollView(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => InfoVideo(video: video,)),
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
                                        Text("   "+
                                          video.name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        Container(
                                          margin: EdgeInsets.only(left: 35),
                                          width: 300,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            image: DecorationImage(
                                              image: NetworkImage(video.thumbnailImageId),
                                              fit: BoxFit.fill,
                                              alignment: Alignment.center
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                      ],
                                    ),
                                  ),
                                ),
                              )
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
          ],
        ),
      ),
    );
  }
}
