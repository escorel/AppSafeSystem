import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {

  // Dados da conexão ao Api remoto
  String _data = "";
  int _total = 0;
  int _cor = 0;
  String _msg = " cor";

  //Array de cores
  List<String> _colorCodes = [ ];

  //Método de recuperação de código numérico para cor exadecimal
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  // Método de recuperação de cores vindas da Api
  void _recuperarCor() async {
    String _status = "";
    http.Response response;
    response = await http.post(
        "https://parseapi.back4app.com/functions/colors",
        headers: {
          'X-Parse-Application-Id': 'XUGUteSRjfXSLvA4AKNAbFwjdF0CfYuInJesxmlF',
          'X-Parse-REST-API-Key': 'X-Parse-REST-API-Key',
          'Content-Type': 'application/json'
        }
    );
    Map<String, dynamic> _retorno = json.decode(response.body);
    String _result = _retorno["result"];
    _status = response.statusCode.toString() + response.body;

    //Verifica se houve erro e processa a entrada de informações
    if(response.statusCode.toString() != "200"){
      setState(() {
        if(_cor <=1){}
        _data = _status+"  "+_cor.toString()+ _msg;
      });
    }else {
      _colorCodes.sort();
      for(int i=0;i < _colorCodes.length ; i++){
        for(int a=0;a < _colorCodes.length ; a++){
          if(_colorCodes[i] == _colorCodes[a]){
            _cor ++;
          }else{
            _cor --;
          }
        };
      }
      setState(() {
        _colorCodes = _retorno["result"];
        _data = _cor.toString()+" Cor(es) única(s)";
      });
    }
  }
  @override

  //Executa a função de carga de cores ao iniciar a aplicação
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _recuperarCor();
    });
  }

  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Cores"),
          backgroundColor: Colors.green,
        ),
        body: Container(
          child: Column(
            children: <Widget>[

              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(_data,),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          child: FloatingActionButton(
                            onPressed: _recuperarCor,
                            elevation: 0.0,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.green,
                            child: Icon(Icons.refresh),
                          ) ,

                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  child: new Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: _colorCodes.length,
                        itemBuilder: (BuildContext context, int index) {

                          return Container(
                            height: 50,
                            color: hexToColor(_colorCodes[index]),
                            child: Center(child: Text(''),

                            ),
                          );
                        }
                    ),
                  )
              ),
            ],
          ),
        )

    );
  }
}