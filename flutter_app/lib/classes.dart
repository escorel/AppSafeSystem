import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'globais.dart' as globals;


class Helpers {

  //Fun de recuperação de código numérico para cor exadecimal
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

// Função de recuperação de cores vindas da Api no formato Json
  void recuperarCor() async {
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
     globals.resultRecuperaCor = parsedJson['result'];
     globals.statusRecuperaCor = response.statusCode;
     globals.bodyRecuperaCor = response.body;
  }



}
