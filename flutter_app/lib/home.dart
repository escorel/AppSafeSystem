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
var _total = 0;

void _recuperarCor() async {

  String _status = "";
  http.Response response;
  response = await http.post(
    _url,
      headers: {
        'X-Parse-Application-Id': 'XUGUteSRjfXSLvA4AKNAbFwjdF0CfYuInJesxmlF',
        'X-Parse-REST-API-Key': 'X-Parse-REST-API-Key',
        'Content-Type': 'application/json'
      }
  );
  Map<String, dynamic> _retorno = json.decode(response.body);

  String _result = _retorno["result"];

  _status = response.statusCode.toString() + response.body;

  if(response.statusCode.toString() != "200"){
    setState(() {
      _data = _status;
    });
  }else {
    setState(() {
      _data = "Sucesso!";
    });
  }

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Cores"),
      ),
      body: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_data),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  child: Image.asset("images/reload.jpg",height: 90),
                  onTap: _recuperarCor,
                ),
              ],
            ),
          ],
        ),

        ),
      );
  }
}
