import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/database/sqlite.dart';
import 'package:flutter_application_1/products/model/product.dart';
import 'package:sqflite/sqflite.dart';

class InventoryOutputController extends GetxController {
  final products = <Product>[].obs;
  final razonesSalida = ['Venta', 'Transferencia', 'Devolución', 'Pérdida'].obs;
  
  final Rx<Product?> selectedProduct = Rx<Product?>(null);
  final cantidad = 0.obs;
  final selectedReason = ''.obs;

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
        products.value = result.map((item) => Product(
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
        )).toList();
      }
    } catch (e) {
      Get.snackbar("Error", 'No se pudieron cargar los productos',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
    }
  }

  void registrarSalida() async {
    if (selectedProduct.value == null || cantidad.value == 0 || selectedReason.isEmpty) {
      Get.snackbar('Error', 'Por favor, complete todos los campos');
      return;
    }

    if (cantidad.value > selectedProduct.value!.inventario) {
      Get.snackbar('Error', 'La cantidad de salida no puede ser mayor que el inventario disponible');
      return;
    }
    
    SqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();

    try {
      // Actualizar el inventario del producto
      int newInventory = selectedProduct.value!.inventario - cantidad.value;
      await db.update(
        'ProductosCatalogo',
        {'inventario': newInventory},
        where: 'Codigo = ?',
        whereArgs: [selectedProduct.value!.codigo],
      );

      // Aquí podrías agregar código para registrar la transacción de salida en otra tabla si es necesario

      Get.snackbar('Éxito', 'Salida de mercancía registrada correctamente');
      
      // Actualizar la lista de productos
      loadProducts();
      
      // Limpiar los campos después de registrar
      selectedProduct.value = null;
      cantidad.value = 0;
      selectedReason.value = '';
    } catch (e) {
      Get.snackbar('Error', 'No se pudo registrar la salida de mercancía');
    }
  }
}