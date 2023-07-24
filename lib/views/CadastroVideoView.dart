import 'package:app_videos/DAO/VideoDAO.dart';
import 'package:app_videos/models/Video.dart';
import 'package:app_videos/views/MeusVideosView.dart';
import 'package:flutter/material.dart';
import 'package:app_videos/DAO/GenreDAO.dart';
import '../DAO/VideoGenreDAO.dart';
import '../models/Genre.dart';


class CadastroVideo extends StatefulWidget {
  final int? iduser;

  const CadastroVideo({Key? key, required this.iduser}) : super(key: key);

  @override
  _CadastroVideoState createState() => _CadastroVideoState(iduser!);
}

class _CadastroVideoState extends State<CadastroVideo> {
  int? userid;

  _CadastroVideoState(int iduser){
    userid = iduser;
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

  void adicionar() async {
    String nome = _controllerNome.text;
    String descricao = _controllerDescricao.text;
    int tipo = int.parse(_controllerTipo.text);
    String restricao = _controllerRestricao.text;
    int duracao = int.parse(_controllerDuracao.text);
    String url = _controllerUrlImagem.text;
    String lancamento = _controllerLancamento.text;

    Video video1 = Video(nome, descricao, tipo, restricao, duracao, url, lancamento, userid!);

    VideoDAO videodao = VideoDAO();

    int? id = await videodao.saveVideo(video1);

    GenreDAO genredao = GenreDAO();

    VideoGenreDAO videoGenreDAO = VideoGenreDAO();

    for (String genre in generosSelecionados) {
      int? genreId = await genredao.findIdByName(genre);
      videoGenreDAO.saveVideoGenre(id, genreId!);
    }
  }


  @override
  void initState() {
    super.initState();
    genredao.list().then((generos) {
      setState(() {
        for(Genre genres in generos) {
          nomesGeneros.add(genres.name);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121921),
      appBar: AppBar(
        title: Text("Cadastro Video"),
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
                      title: Text(
                        nomesGeneros[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      activeColor: Colors.indigo,
                      checkColor: Colors.white,
                      value: generosCheckbox[index],
                      onChanged: (valor) {
                        atualizarCheckbox(index, valor!);
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
              ),
              Padding(padding: EdgeInsets.only(top: 25)),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.all(16.0),
                  ),
                ),
                onPressed: () {
                  adicionar();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MeusVideos(iduser: userid)),
                  );
                },
                child: Text('Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
