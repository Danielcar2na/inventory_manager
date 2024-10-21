import 'package:flutter/material.dart';
import 'package:flutter_application_1/login/view/login_screen.dart';
import 'package:flutter_application_1/products/view/product_screen.dart';
import 'package:flutter_application_1/products/view_model/product_view_model.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {

  void consultaInventario() {
    Get.put(ProductViewModel());
    Get.to(() => ProductScreen());
  }

  void entradaInventario() {
    print('Botón 2 presionado');
  }

  void salidaInventario() {
    print('Botón 3 presionado');
  }

  void showLogoutConfirmation() {
    Get.dialog(
      AlertDialog(
        title: Text('Cerrar sesión'),
        content: Text('¿Está seguro de que desea cerrar sesión?'),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Cerrar sesión'),
            onPressed: () {
              // Aquí puedes añadir lógica adicional para cerrar sesión si es necesario
              Get.offAll(() => LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}