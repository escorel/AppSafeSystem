import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


/*
      Uri.encodeFull("https://parseapi.back4app.com/functions/colors"),
      headers: {
        "X-Parse-Application-Id": " XUGUteSRjfXSLvA4AKNAbFwjdF0CfYuInJesxmlF",
        "X-Parse-REST-API-Key": " KUXVh7zrFLhs1uS849XUog6CizcNviEP9rdMWfg1",
        "Content-Type": "application/json",
        }
*/
// Dados da conexão ao App remoto
String _data = "";
//String _url = "https://viacep.com.br/ws/01311300/json";
String _url = "https://parseapi.back4app.com/functions/colors";


void _recuperarCor() async {

  String _status = "";
  http.Response response;
  response = await http.post(
    _url,
      headers: {
        'X-Parse-Application-Id': 'XUGUteSRjfXSLvA4AKNAbFwjdF0CfYuInJesxmlF',
        'X-Parse-REST-API-Key': 'X-Parse-REST-API-Key',
        'Content-Type': ' application/json '
      }
  );
  Map<String, dynamic> _retorno = json.decode(response.body);

  String _result = _retorno["result"];

  _status = response.statusCode.toString() + response.body;

  setState(() {
    _data = _status;
  });


}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cores"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(_data),
                MaterialButton(
                  child: Text("dsdsdsdd"),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("clique aqui"),
                  onPressed: _recuperarCor,
                )
              ],
            )


          ],
        ),
      ),

    );
  }
}
