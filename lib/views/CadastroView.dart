import 'package:app_videos/DAO/UserDAO.dart';
import 'package:app_videos/models/User.dart';
import 'package:flutter/material.dart';

import 'LoginView.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroView();
}

class _CadastroView extends State<CadastroView> {

  TextEditingController _controllerNome = TextEditingController();

  TextEditingController _controllerSenha = TextEditingController();

  TextEditingController _controllerEmail = TextEditingController();
  
  _cadastrar(){
    String nome = _controllerNome.text;
    String senha = _controllerSenha.text;
    String email = _controllerEmail.text;
    User user = new User.noId(nome,email,senha);

    UserDAO userdao = new UserDAO();

    userdao.saveUser(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121921),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Cadastro"),
        backgroundColor: Colors.black26,
      ),
      body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 100),
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
                Padding(padding: EdgeInsets.only(top: 50)),
                TextField(
                  controller: _controllerEmail,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Digite seu email',
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 75)),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(16.0),
                    ),
                  ),
                  onPressed: () {
                    _cadastrar();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text('Cadastrar'),
                ),
              ],
            ),
          )
      ),
    );
  }
}
