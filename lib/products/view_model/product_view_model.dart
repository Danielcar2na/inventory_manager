import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/sqlite.dart';
import 'package:flutter_application_1/products/model/product.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class ProductViewModel extends GetxController {

  ScrollController scrollController = ScrollController();
  ProductViewModel();
  RxList<Product> productList = RxList();
  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void getProducts() async {
    SqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();
    Product? product;

    String statement =
        '''SELECT * FROM ProductosCatalogo''';

    try {
      List<Map> result = await db.rawQuery(statement);
      if (result.isNotEmpty) {
        for (var item in result) {
          product = Product(
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
          );
          productList.add(product);
        }
      }
    } catch (e) {
      Get.snackbar("Error", 'El producto no existe',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
    }
  }
  //Método para eliminar un producto
  void deleteProduct(int index) async {
    if (index < 0 || index >= productList.length) {
      Get.snackbar("Error", "Producto no encontrado");
      return;
    }

    // Obtener el producto a eliminar
    Product productToDelete = productList[index];

    // Eliminar de la base de datos
    SqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();
    
    try {
     int test = await db.delete(
        'ProductosCatalogo',
        where: 'Codigo = ?',
        whereArgs: [productToDelete.codigo],
      );
      print(test);

      // Eliminar de la lista
      productList.removeAt(index);

      Get.snackbar("Éxito", "Producto eliminado correctamente");
    } catch (e) {
      Get.snackbar("Error", "No se pudo eliminar el producto");
    }
  }


///////////////////////////////////////////////////////////////////
void editProduct(int index, Product updatedProduct) async {
  if (index < 0 || index >= productList.length) {
    Get.snackbar("Error", "Producto no encontrado");
    return;
  }

  // Obtener el producto a editar
  Product productToEdit = productList[index];

  // Actualizar la base de datos
  SqliteService sqliteService = SqliteService();
  Database db = await sqliteService.openDB();

  try {
    int rowsAffected = await db.update(
      'ProductosCatalogo',
      updatedProduct.toJson(), // Asegúrate de tener un método toJson en tu modelo Product
      where: 'Codigo = ?',
      whereArgs: [productToEdit.codigo],
    );

    if (rowsAffected > 0) {
      // Actualizar la lista local
      productList[index] = updatedProduct; // Reemplazar el producto en la lista
      Get.snackbar("Éxito", "Producto editado correctamente");
    } else {
      Get.snackbar("Error", "No se encontró el producto para editar");
    }
  } catch (e) {
    Get.snackbar("Error", "No se pudo editar el producto");
  }
}

 // Método para agregar un producto
  void addProduct(Product newProduct) async {
    SqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();

    // Insertar el nuevo producto en la base de datos
    try {
      await db.insert(
        'ProductosCatalogo',
        newProduct.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace, // Reemplazar si existe
      );

      // Añadir el producto a la lista
      productList.add(newProduct);

      Get.snackbar("Éxito", "Producto agregado correctamente");
    } catch (e) {
      Get.snackbar("Error", "No se pudo agregar el producto");
    }
  }


}


