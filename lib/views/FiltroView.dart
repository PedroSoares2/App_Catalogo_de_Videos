import 'package:app_videos/DAO/VideoDAO.dart';
import 'package:app_videos/views/MenuInicialComFiltroView.dart';
import 'package:app_videos/views/MenuInicialSemLoginFiltroView.dart';
import 'package:flutter/material.dart';
import '../DAO/GenreDAO.dart';
import '../models/Video.dart';

class Filtro extends StatefulWidget {
  final int id;

  const Filtro({Key? key, required this.id}) : super(key: key);

  @override
  State<Filtro> createState() => _FiltroState(id);
}

class _FiltroState extends State<Filtro> {
  GenreDAO genredao = GenreDAO();
  List<String> nomesGeneros = [];
  String? generoSelecionado;
  bool filmeSelecionado = false;
  bool serieSelecionada = false;

  @override
  void initState() {
    super.initState();
    genredao.list().then((generos) {
      setState(() {
        nomesGeneros = generos.map((genre) => genre.name).toList();
      });
    });
  }

  int? userid;

  _FiltroState(int iduser) {
    userid = iduser;
  }

  Future<List<Video>> filtrarVideos() async {
    List<Video> videosSelecionados = [];
    VideoDAO videoDAO = VideoDAO();

    if (generoSelecionado == null && !filmeSelecionado && !serieSelecionada) {
      videosSelecionados = await videoDAO.list();
    } else if (generoSelecionado == null && filmeSelecionado) {
      videosSelecionados = await videoDAO.listByTipo(0);
    } else if (generoSelecionado == null && serieSelecionada) {
      videosSelecionados = await videoDAO.listByTipo(1);
    } else if (generoSelecionado != null && !filmeSelecionado && !serieSelecionada) {
      videosSelecionados = await videoDAO.listByGenre(generoSelecionado);
    } else {
      int type = filmeSelecionado ? 0 : 1;
      videosSelecionados = await videoDAO.listByTipoAndGenre(type, generoSelecionado!);
    }

    return videosSelecionados;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121921),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Categorias"),
        backgroundColor: Colors.black26,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 40, right: 40, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  CheckboxListTile(
                    title: Text("Filme",
                        style: TextStyle(color: Colors.white)),
                    value: filmeSelecionado,
                    activeColor: Colors.indigo,
                    checkColor: Colors.white,
                    onChanged: (valor) {
                      setState(() {
                        if (filmeSelecionado) {
                          filmeSelecionado = false;
                        } else {
                          filmeSelecionado = true;
                          serieSelecionada = false;
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text("Série",
                        style: TextStyle(color: Colors.white)),
                    value: serieSelecionada,
                    activeColor: Colors.indigo,
                    checkColor: Colors.white,
                    onChanged: (valor) {
                      setState(() {
                        if (serieSelecionada) {
                          serieSelecionada = false;
                        } else {
                          serieSelecionada = true;
                          filmeSelecionado = false;
                        }
                      });
                    },
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 50)),
              Text(
                "Gêneros",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Divider(
                color: Colors.white,
                thickness: 1,
                height: 1,
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Column(
                children: List<Widget>.generate(nomesGeneros.length, (index) {
                  if (index < nomesGeneros.length) {
                    return CheckboxListTile(
                      title: Text(nomesGeneros[index],
                          style: TextStyle(color: Colors.white)),
                      value: generoSelecionado == nomesGeneros[index],
                      activeColor: Colors.indigo,
                      checkColor: Colors.white,
                      onChanged: (valor) {
                        setState(() {
                          if (generoSelecionado == nomesGeneros[index]) {
                            generoSelecionado = null;
                          } else {
                            generoSelecionado = nomesGeneros[index];
                          }
                        });
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
              ),
              SizedBox(height: 10),
              Padding(padding: EdgeInsets.only(top: 50)),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.all(16.0),
                  ),
                ),
                onPressed: () {
                  if(userid == 1000){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuInicialSemLoginFiltro(videosFiltrados: filtrarVideos())),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuInicialFiltro(id: userid!, videosFiltrados: filtrarVideos())),
                    );
                  }
                },
                child: Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
