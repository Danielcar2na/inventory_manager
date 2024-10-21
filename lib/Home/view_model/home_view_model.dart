import 'package:flutter/material.dart';
import 'package:flutter_application_1/Inventory_output/view/Inventory_output_screen.dart';
import 'package:flutter_application_1/Inventory_output/view_model/inventory_output_view_model.dart';
import 'package:flutter_application_1/inventory_input/view/Inventory_input_screen.dart';
import 'package:flutter_application_1/inventory_input/view_model/Inventory_input_view_model.dart';
import 'package:flutter_application_1/login/view/login_screen.dart';
import 'package:flutter_application_1/products/view/product_screen.dart';
import 'package:flutter_application_1/products/view_model/product_view_model.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {

  void queryInventory() {
    Get.put(ProductViewModel());
    Get.to(() => ProductScreen());
  }

  void inputStock() {
    Get.put(InventoryInputViewModel());
    Get.to(()=> InventoryInputScreen());
  }

  void outputStock() {
    Get.put(InventoryOutputViewModel());
    Get.to(()=> InventoryOutputScreen());
  }

  void showLogoutConfirmation() {
    Get.dialog(
      AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Está seguro de que desea cerrar sesión?'),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: const Text('Cerrar sesión'),
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