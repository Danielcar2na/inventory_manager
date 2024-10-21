import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/sqlite.dart';
import 'package:flutter_application_1/products/model/product.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class InventoryOutputViewModel extends GetxController {
  RxList<Product> productList = RxList<Product>();
  Rx<Product?> selectedProduct = Rx<Product?>(null);
  RxInt quantity = 0.obs;
  RxString reason = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void loadProducts() async {
    SqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();

    try {
      List<Map> result = await db.rawQuery('SELECT * FROM ProductosCatalogo');
      if (result.isNotEmpty) {
        productList.clear();
        for (var item in result) {
          Product product = Product(
            agrupacion: item["Agrupacion"],
            archivo: item["Archivo"],
            bodega: item["Bodega"],
            categoria: item["Categoria"],
            cenExt2: item["Cen_ext2"],
            clave: item["Clave"],
            codigo: item["Codigo"],
            core: item["Core"],
            ean: item["Ean"],
            gm4: item["GM4"],
            grupo: item["Grupo"],
            itf: item["Itf"],
            iva: item["Iva"],
            linea: item["Linea"],
            lineaproduccion: item["Lineaproduccion"],
            marca: item["Marca"],
            nombre: item["Nombre"],
            pagaPastilla: item["Paga_pastilla"],
            peso: item["Peso"]?.toDouble(),
            portafolio: item["Portafolio"],
            precio: item["Precio"],
            saldo: item["Saldo"],
            sector: item["Sector"],
            subcategoria: item["Subcategoria"],
            sublinea: item["Sublinea"],
            unidades: item["Unidades"],
            unidadesxcaja: item["Unidadesxcaja"],
            unidadmedida: item["Unidadmedida"],
            vendedor: item["Vendedor"],
            marcadd: item["marcadd"],
            createAt: item["CreateAt"] != null ? DateTime.parse(item["CreateAt"]) : DateTime.now(),
            inventario: item["inventario"] ?? 0,
          );
          productList.add(product);
        }
      }
    } catch (e) {
      Get.snackbar("Error", 'No se pudieron cargar los productos',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
    }
  }

  void setSelectedProduct(Product product) {
    selectedProduct.value = product;
  }

  void setQuantity(int value) {
    quantity.value = value;
  }

  void setReason(String value) {
    reason.value = value;
  }

  Future<void> registerOutput() async {
    if (selectedProduct.value == null || quantity.value <= 0 || reason.value.isEmpty) {
      Get.snackbar("Error", "Por favor, complete todos los campos correctamente");
      return;
    }

    if (quantity.value > selectedProduct.value!.inventario) {
      Get.snackbar("Error", "La cantidad de salida no puede ser mayor que el inventario disponible");
      return;
    }

    SqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();

    try {
      // Actualizar el inventario del producto
      int newInventory = selectedProduct.value!.inventario - quantity.value;
      await db.update(
        'ProductosCatalogo',
        {'inventario': newInventory},
        where: 'Codigo = ?',
        whereArgs: [selectedProduct.value!.codigo],
      );

      // Aquí podrías agregar código para registrar la transacción de salida en otra tabla si es necesario

      Get.snackbar("Éxito", "Salida de mercancía registrada correctamente");
      
      // Actualizar la lista de productos
      loadProducts();
      
      // Limpiar los campos
      selectedProduct.value = null;
      quantity.value = 0;
      reason.value = '';
    } catch (e) {
      Get.snackbar("Error", "No se pudo registrar la salida de mercancía");
    }
  }
}