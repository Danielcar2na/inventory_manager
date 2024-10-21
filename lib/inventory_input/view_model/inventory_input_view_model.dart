import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/sqlite.dart';
import 'package:flutter_application_1/products/model/product.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class InventoryInputViewModel extends GetxController {
  RxList<Product> productList = RxList<Product>();
  final Rx<Product?> selectedProduct = Rx<Product?>(null);
  final RxInt cantidad = 0.obs;
  final RxString selectedReason = ''.obs;
  final RxString numeroFactura = ''.obs;

  final razonesEntrada = ['Compra', 'Devolución', 'Ajuste de Inventario', 'Producción'].obs;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void getProducts() async {
    SqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();

    String statement = '''SELECT * FROM ProductosCatalogo''';

    try {
      List<Map> result = await db.rawQuery(statement);
      if (result.isNotEmpty) {
        productList.clear();
        for (var item in result) {
          DateTime? createAt;
          try {
            createAt = item["CreateAt"] != null ? DateTime.parse(item["CreateAt"]) : null;
          } catch (e) {
            print("Error parsing date: ${item["CreateAt"]}");
            createAt = null;
          }

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
            createAt: createAt ?? DateTime.now(),
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

  void setSelectedProduct(Product? product) {
    selectedProduct.value = product;
  }

  void setCantidad(int value) {
    cantidad.value = value;
  }

  void setSelectedReason(String reason) {
    selectedReason.value = reason;
  }

  void setNumeroFactura(String numero) {
    numeroFactura.value = numero;
  }

  Future<void> registrarEntrada() async {
    if (selectedProduct.value == null || cantidad.value == 0 || selectedReason.isEmpty || numeroFactura.isEmpty) {
      Get.snackbar("Error", "Por favor, complete todos los campos",
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
      return;
    }

    SqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();

    try {
      // Actualizar el inventario del producto
      int newInventory = selectedProduct.value!.inventario + cantidad.value;
      await db.update(
        'ProductosCatalogo',
        {'inventario': newInventory},
        where: 'Codigo = ?',
        whereArgs: [selectedProduct.value!.codigo],
      );

      // Aquí podrías agregar código para registrar la transacción de entrada en otra tabla si es necesario
      // Por ejemplo:
      // await db.insert('InventoryTransactions', {
      //   'productCode': selectedProduct.value!.codigo,
      //   'quantity': cantidad.value,
      //   'type': 'input',
      //   'reason': selectedReason.value,
      //   'invoiceNumber': numeroFactura.value,
      //   'date': DateTime.now().toIso8601String(),
      // });

      Get.snackbar("Éxito", "Entrada de mercancía registrada correctamente",
          backgroundColor: Colors.green, colorText: Colors.white);
      
      // Actualizar la lista de productos
      getProducts();
      
      // Limpiar los campos después de registrar
      selectedProduct.value = null;
      cantidad.value = 0;
      selectedReason.value = '';
      numeroFactura.value = '';
    } catch (e) {
      Get.snackbar("Error", "No se pudo registrar la entrada de mercancía",
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
    }
  }
}