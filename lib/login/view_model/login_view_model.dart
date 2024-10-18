import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/sqlite.dart';
import 'package:flutter_application_1/home/view_model/home_view_model.dart';
import 'package:flutter_application_1/login/model/seller.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class LoginViewModel extends GetxController {
  TextEditingController userTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();

  @override
  onInit() {
    userTextField.text = '4160';
    passwordTextField.text = '4160';
    super.onInit();
  }

  Future<void> login() async {
    SqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();
    String usuario = userTextField.text;
    String password = passwordTextField.text;

    String statement =
        "SELECT * FROM usuario WHERE usuario = $usuario AND password = $password";
    try {
      List<Map> result = await db.rawQuery(statement);
      if (result.isNotEmpty) {
        searchSeller(usuario);
      }
    } catch (e) {
      Get.snackbar("Error", 'El usuario o la contraseña son incorrectos',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
    }
  }

  void searchSeller(String codigo) async {
    SqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();
    Seller? seller;

    String statement =
        "SELECT bodega, codigo, nombre, fechaLabores, fechaConsecutivo, consecutivo, empresa, distrito, portafolio, moneda, tipo FROM vendedor WHERE codigo = $codigo";
    try {
      List<Map> result = await db.rawQuery(statement);
      if (result.isNotEmpty) {
        for (var item in result) {
          seller = Seller(
              bodega: item['bodega'],
              nombre: item['nombre'],
              consecutivo: item['consecutivo'],
              codigo: item['codigo'],
              moneda: item['moneda'],
              tipo: item['tipo'],
              empresa: item['empresa'],
              fechaLabores: item['fechaLabores'],
              fechaConsecutivo: item['fechaConsecutivo'],
              portafolio: item['portafolio'],
              distrito: item['distrito']);
        }

        Get.put(HomeViewModel(seller: seller!));
      }
    } catch (e) {
      Get.snackbar("Error", 'El usuario no existe',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
    }
  }
}
//print('resutl:' + result.first.toString());