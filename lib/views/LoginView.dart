
import 'package:app_videos/DAO/UserDAO.dart';
import 'package:app_videos/views/CadastroView.dart';
import 'package:app_videos/views/MenuInicialView.dart';
import 'package:flutter/material.dart';

import '../DAO/GenreDAO.dart';
import '../models/User.dart';
import 'MenuInicialSemLoginView.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _controllerNome = TextEditingController();

  TextEditingController _controllerSenha = TextEditingController();

  Future<User?> _logar() {
    String usuario = _controllerNome.text;
    String senha = _controllerSenha.text;

    UserDAO userdao = new UserDAO();

    GenreDAO genredao = new GenreDAO();

    genredao.saveGenres();


    return userdao.getUserByUsernameAndPassword(usuario, senha);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121921),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Login"),
        backgroundColor: Colors.black26,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 40, right: 40, top: 150),
          child:  Column(
            children: [
              TextField(
                controller: _controllerNome,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  hintText: 'Digite seu nome de usuário',
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 50)),
              TextField(
                controller: _controllerSenha,
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite sua senha',
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 75)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.only(top: 16.0, bottom: 16.0, left: 28, right: 28),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                      ),
                      onPressed: () {
                        _logar().then((user) {
                          if (user == null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Erro'),
                                  content: Text('Usuário não encontrado'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MenuInicial(iduser: user.id!)),
                            );
                          }
                        });
                      },
                      child: Text('Logar'),
                    ),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(16.0),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CadastroView())
                        );
                      },
                      child: Text('Cadastrar'),
                    ),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(16.0),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MenuInicialSemLogin())
                        );
                      },
                      child: Text('Entrar sem logar'),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
