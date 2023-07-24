import 'package:app_videos/DAO/VideoDAO.dart';
import 'package:app_videos/models/Video.dart';
import 'package:flutter/material.dart';
import 'package:app_videos/DAO/GenreDAO.dart';
import '../DAO/VideoGenreDAO.dart';
import '../models/Genre.dart';
import 'MeusVideosView.dart';


class AtualizarVideo extends StatefulWidget {
  final Video? video;

  const AtualizarVideo({Key? key, required this.video}) : super(key: key);

  @override
  _AtualizarVideoState createState() => _AtualizarVideoState(video!);
}

class _AtualizarVideoState extends State<AtualizarVideo> {
  Video? video;

  _AtualizarVideoState(Video video){
    this.video = video;
  }

  @override
  void initState() {
    super.initState();
    _controllerNome.text = video!.name;
    _controllerDescricao.text = video!.description;
    _controllerTipo.text = video!.type.toString();
    _controllerRestricao.text = video!.ageRestriction;
    _controllerDuracao.text = video!.durationMinutes.toString();
    _controllerUrlImagem.text = video!.thumbnailImageId;
    _controllerLancamento.text = video!.releaseDate;

    GenreDAO genreDAO = GenreDAO();

    genredao.list().then((generos) {
      genreDAO.SelectGenres(video!).then((generosAssociados) {
        setState(() {
          nomesGeneros = generos.map((genre) => genre.name).toList();

          generosCheckbox = List<bool>.filled(nomesGeneros.length, false);

          for (Genre genre in generosAssociados) {
            int index = nomesGeneros.indexOf(genre.name);
            if (index >= 0) {
              generosCheckbox[index] = true;
            }
          }
        });
      });
    });
  }


  GenreDAO genredao = GenreDAO();
  List<String> nomesGeneros = [];

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerDescricao = TextEditingController();
  TextEditingController _controllerTipo = TextEditingController();
  TextEditingController _controllerRestricao = TextEditingController();
  TextEditingController _controllerDuracao = TextEditingController();
  TextEditingController _controllerUrlImagem = TextEditingController();
  TextEditingController _controllerLancamento = TextEditingController();


  List<String> generosSelecionados = [];
  List<bool> generosCheckbox = List<bool>.filled(6, false);

  void atualizarCheckbox(int index, bool valor) {
    setState(() {
      generosCheckbox[index] = valor;
      if (valor) {
        generosSelecionados.add(nomesGeneros[index]);
      } else {
        generosSelecionados.remove(nomesGeneros[index]);
      }
    });
  }

  void atualizar() async {
    String nome = _controllerNome.text;
    String descricao = _controllerDescricao.text;
    int tipo = int.parse(_controllerTipo.text);
    String restricao = _controllerRestricao.text;
    int duracao = int.parse(_controllerDuracao.text);
    String url = _controllerUrlImagem.text;
    String lancamento = _controllerLancamento.text;

    video!.name = nome;
    video!.description = descricao;
    video!.type = tipo;
    video!.ageRestriction = restricao;
    video!.durationMinutes = duracao;
    video!.thumbnailImageId = url;
    video!.releaseDate = lancamento;

    VideoDAO videodao = VideoDAO();

    videodao.atualizarVideo(video!);

    GenreDAO genredao = GenreDAO();

    VideoGenreDAO videoGenreDAO = VideoGenreDAO();

    int? id = video!.id;

    videoGenreDAO.deleteById(id!);

    for (String genre in generosSelecionados) {
      int? genreId = await genredao.findIdByName(genre);
      videoGenreDAO.saveVideoGenre(id, genreId!);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121921),
      appBar: AppBar(
        title: Text("Atualizar Video"),
        backgroundColor: Colors.black26,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 40, right: 40, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: _controllerNome,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Digite o nome do vídeo',
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: _controllerDescricao,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Digite a descrição',
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: _controllerTipo,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Tipo (0 - Filme, 1 - Série)',
                  hintText: 'Digite o tipo do vídeo - (0 - Filme, 1 - Série)',
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: _controllerRestricao,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Restrição de idade',
                  hintText: 'Digite',
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: _controllerDuracao,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Duração  (Em minutos totais)',
                  hintText: 'Digite o total de minutos de duracao',
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: _controllerUrlImagem,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Url da imagem',
                  hintText: 'Digite a URL da imagem',
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: _controllerLancamento,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Data de lançamento',
                  hintText: 'Digite a data de lançamento',
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              Column(
                children: List<Widget>.generate(nomesGeneros.length, (index) {
                  if (index < nomesGeneros.length) {
                    return CheckboxListTile(
                      title: Text(nomesGeneros[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      value: generosCheckbox[index],
                      activeColor: Colors.indigo,
                      checkColor: Colors.white,
                      onChanged: (valor) {
                        atualizarCheckbox(index, valor!);
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
              ),
              Padding(padding: EdgeInsets.only(top: 50)),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.all(16.0),
                  ),
                ),
                onPressed: () {
                  atualizar();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MeusVideos(iduser: video!.idUser)),
                  );
                },
                child: Text('Atualizar')),
            ],
          ),
        ),
      ),
    );
  }
}
