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

// Dados da conexão ao App remoto
  String _data = "";
  String _url = "https://parseapi.back4app.com/functions/colors";
  var _total = 0;

  List<String> litens = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"];
  List<int> colorCodes = [600, 500, 100,500, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100];

// Método de recuperação de cores vindas da Api
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
          title: Text("Cores"),
          backgroundColor: Colors.green,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("_data",),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          child: Image.asset("images/reload.jpg",height: 100,alignment: Alignment.topRight,),
                          onTap: _recuperarCor,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  child: new Expanded(child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: litens.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 50,
                          color: Colors.amberAccent[colorCodes[index]],
                          child: Center(child: Text('Entry ${litens[index]}')),
                        );
                      }
                  ))
              ),
            ],
          ),
        )

    );
  }
}

/*
Container(
       child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              color: Colors.white,
              alignment: Alignment.topRight,
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("_data",),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      GestureDetector(
                        child: Image.asset("images/reload.jpg",height: 100,alignment: Alignment.topRight,),
                        onTap: _recuperarCor,
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              child:
              ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Container(
                    height: 50,
                    color: Colors.amber[600],
                    child: const Center(child: Text('Entry A')),
                  ),
                  Container(
                    height: 50,
                    color: Colors.amber[500],
                    child: const Center(child: Text('Entry B')),
                  ),
                  Container(
                    height: 50,
                    color: Colors.amber[100],
                    child: const Center(child: Text('Entry C')),
                  ),
                ],
              )
              ,
            )
          ],
        ),
      )
* */