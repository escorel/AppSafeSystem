import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:collection';
import 'classes.dart';
import 'globais.dart' as globals;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Helpers helpers = Helpers();

  // Função de recuperação de cores vindas da Api no formato Json
  void _recuperarCor() async {
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
    globals.colorCodes = result;

    //Verifica se houve erro e processa a entrada de informações
    if(response.statusCode != 200){
      setState(() {
          globals.data =  response.statusCode.toString() + response.body;
      });
    }else {

      //Recebe o valor do array inicial sem os valores duplicados
      globals.colorCodesUnic = LinkedHashSet<String>.from(globals.colorCodes).toList();

      //Verifica a quantidade de cores únicas e exibe mensagem apropriada
      setState(() {
        //_colorCodes = _retorno["result"];
        if (globals.colorCodesUnic.length <=1){
          globals.data = globals.colorCodesUnic.length.toString()+" Cor única";
        }else{
          globals.data = globals.colorCodesUnic.length.toString()+" Cores únicas";
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
                padding: EdgeInsets.only(left:20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(globals.data,),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: FloatingActionButton(
                            onPressed: _recuperarCor,
                            elevation: 0.0,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.green,
                            child: Icon(Icons.refresh),
                          )
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
                        itemCount: globals.colorCodes.length,
                        itemBuilder: (BuildContext context, int index) {

                          return Container(
                            margin: EdgeInsets.only(top:10.0),
                            decoration: BoxDecoration(
                                color: helpers.hexToColor(globals.colorCodes[index]),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0)
                                )
                            ),
                            height: 80,
                            child: Center(child: Text(""),//helpers.hexToColor(globals.colorCodes[index]).toString()+" "+globals.colorCodes[index]),
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