import 'package:flutter/material.dart';
import 'package:flutter_application_1/Home/view/home_screen.dart';
import 'package:flutter_application_1/database/sqlite.dart';
import 'package:flutter_application_1/login/model/seller.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class LoginViewModel extends GetxController {
  TextEditingController userTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    userTextField.text = '4160';
    passwordTextField.text = '4160';
    super.onInit();
  }

  bool _validateInput(String usuario, String password) {
    if (usuario.isEmpty || password.isEmpty) {
      Get.snackbar("Error", 'Por favor, complete todos los campos',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
      return false;
    }
    if (password.length != 4 || !RegExp(r'^[0-9]{4}$').hasMatch(password)) {
      Get.snackbar("Error", 'La contraseña debe ser de 4 dígitos',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
      return false;
    }
    return true;
  }

  Future<void> login() async {
    String usuario = userTextField.text.trim();
    String password = passwordTextField.text;

    if (!_validateInput(usuario, password)) return;

    isLoading.value = true;

    try {
      SqliteService sqliteService = SqliteService();
      Database db = await sqliteService.openDB();

      List<Map> result = await db.rawQuery(
        'SELECT * FROM usuario WHERE usuario = ? AND password = ?',
        [usuario, password]
      );

      if (result.isNotEmpty) {
        await searchSeller(usuario);
        // Navegar a la pantalla Home después de un login exitoso
        Get.off(() => HomeScreen());
      } else {
        Get.snackbar("Error", 'El usuario o la contraseña son incorrectos',
            backgroundColor: Colors.red.shade400, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", 'Ocurrió un error inesperado. Por favor, intente de nuevo.',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchSeller(String codigo) async {
    try {
      SqliteService sqliteService = SqliteService();
      Database db = await sqliteService.openDB();
      Seller? seller;

      List<Map> result = await db.rawQuery(
        'SELECT bodega, codigo, nombre, fechaLabores, fechaConsecutivo, consecutivo, empresa, distrito, portafolio, moneda, tipo FROM vendedor WHERE codigo = ?',
        [codigo]
      );

      if (result.isNotEmpty) {
        var item = result.first;
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
          distrito: item['distrito']
        );

        // Aquí puedes hacer algo con la información del vendedor si es necesario
        // Por ejemplo, almacenarla en el estado global o en un servicio
      } else {
        Get.snackbar("Error", 'No se encontró información del vendedor',
            backgroundColor: Colors.red.shade400, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", 'Ocurrió un error al buscar la información del vendedor',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
    }
  }
}