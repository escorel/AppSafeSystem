import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:collection';
//import 'package:queries/collections.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Declaração de variáveis da classe
  String _data = "";
  int _cor = 0;
  String _msg = " cor";
  int _totalCor = 0;

  //Array de cores
  var _colorCodes = [];
  var _colorCodesUnic = [];


  //Fun de recuperação de código numérico para cor exadecimal
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  // Função de recuperação de cores vindas da Api no formato Json
  void _recuperarCor() async {
    String _status = "";
    http.Response response;
    response = await http.post(
        "https://parseapi.back4app.com/functions/colors",
        headers: {
          'X-Parse-Application-Id': 'XUGUteSRjfXSLvA4AKNAbFwjdF0CfYuInJesxmlF',
          'X-Parse-REST-API-Key': 'KUXVh7zrFLhs1uS849XUog6CizcNviEP9rdMWfg1',
          'Content-Type': 'application/json'
        }
    );

    // Recuperando Json para Lista
    var parsedJson = json.decode(response.body);
    var result = parsedJson['result'];
    _colorCodes = result;

    //Verifica se houve erro e processa a entrada de informações
    if(response.statusCode != 200){
      setState(() {
          _data =  response.statusCode.toString() + response.body;
      });
    }else {
      _cor = 0;

      _colorCodesUnic = LinkedHashSet<String>.from(_colorCodes).toList();

      _cor = _colorCodesUnic.length;

      setState(() {
        //_colorCodes = _retorno["result"];
        if (_cor <=1){
          _data = _cor.toString()+" Cor única";
        }else{
          _data = _cor.toString()+" Cores únicas";
        }
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            margin: EdgeInsets.only(top:10.0),
                            decoration: BoxDecoration(
                                color: hexToColor(_colorCodes[index]),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0)
                                )
                            ),
                            height: 80,
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