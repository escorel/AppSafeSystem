import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/home.dart';
import 'package:flutterapp/classes.dart';


void main(){
  final helper = Helpers();

  test("Validação de chamada", (){
    Home();
  });
  test("Chama retorno de cores", (){

    var cor ="#63E817";
    var cor2 = "Color(0xff63e817)";
    expect(helper.hexToColor(cor),cor2);

  });

}