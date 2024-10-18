import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/sqlite.dart';
import 'package:flutter_application_1/products/model/product.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class ProductViewModel extends GetxController {
  ScrollController scrollController = ScrollController();
  RxList<Product> productList = RxList();
  RxList<Product> filteredProductList = RxList();

  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);

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
          print("Inventario leído de la base de datos: ${item["inventario"]}");
          productList.add(product);
        }
      }
      filteredProductList.value = productList;
    } catch (e) {
      Get.snackbar("Error", 'No se pudieron cargar los productos',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
    }
  }

  void filterProductsByDate() {
    if (startDate.value == null || endDate.value == null) {
      filteredProductList.value = productList;
    } else {
      filteredProductList.value = productList.where((product) {
        return product.createAt.isAfter(startDate.value!) &&
               product.createAt.isBefore(endDate.value!.add(Duration(days: 1)));
      }).toList();
    }
  }

  void setStartDate(DateTime date) {
    startDate.value = date;
    filterProductsByDate();
  }

  void setEndDate(DateTime date) {
    endDate.value = date;
    filterProductsByDate();
  }

  void deleteProduct(int index) async {
    if (index < 0 || index >= filteredProductList.length) {
      Get.snackbar("Error", "Producto no encontrado");
      return;
    }

    Product productToDelete = filteredProductList[index];

    SqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();
    
    try {
      await db.delete(
        'ProductosCatalogo',
        where: 'Codigo = ?',
        whereArgs: [productToDelete.codigo],
      );

      productList.remove(productToDelete);
      filteredProductList.remove(productToDelete);

      Get.snackbar("Éxito", "Producto eliminado correctamente");
    } catch (e) {
      Get.snackbar("Error", "No se pudo eliminar el producto");
    }
  }

  void editProduct(int index, Product updatedProduct) async {
    if (index < 0 || index >= filteredProductList.length) {
      Get.snackbar("Error", "Producto no encontrado");
      return;
    }

    Product productToEdit = filteredProductList[index];

    SqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();

    try {
      int rowsAffected = await db.update(
        'ProductosCatalogo',
        updatedProduct.toJson(),
        where: 'Codigo = ?',
        whereArgs: [productToEdit.codigo],
      );

      if (rowsAffected > 0) {
        int originalIndex = productList.indexWhere((p) => p.codigo == productToEdit.codigo);
        if (originalIndex != -1) {
          productList[originalIndex] = updatedProduct;
        }
        filteredProductList[index] = updatedProduct;
        Get.snackbar("Éxito", "Producto editado correctamente");
      } else {
        Get.snackbar("Error", "No se encontró el producto para editar");
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo editar el producto");
    }
  }

  void addProduct(Product newProduct) async {
    SqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();

    try {
      await db.insert(
        'ProductosCatalogo',
        newProduct.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      productList.add(newProduct);
      filterProductsByDate();

      Get.snackbar("Éxito", "Producto agregado correctamente");
    } catch (e) {
      Get.snackbar("Error", "No se pudo agregar el producto");
    }
  }

  Future<int> getNextCodigo() async {
    SqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();

    int nextCodigo = 1;

    try {
      List<Map> result = await db.rawQuery('''
        SELECT MAX(CAST(Codigo AS INTEGER)) as maxCodigo FROM ProductosCatalogo
      ''');

      if (result.isNotEmpty && result[0]['maxCodigo'] != null) {
        nextCodigo = int.parse(result[0]['maxCodigo'].toString()) + 1;
      }
    } catch (e) {
      print("Error al obtener el siguiente código: $e");
    }

    return nextCodigo;
  }

  Future<void> increaseInventory(int index) async {
    if (index < 0 || index >= filteredProductList.length) {
      Get.snackbar("Error", "Producto no encontrado");
      return;
    }

    Product product = filteredProductList[index];
    int newInventory = product.inventario + 1;

    await _updateInventory(product, newInventory);
  }

  Future<void> decreaseInventory(int index) async {
    if (index < 0 || index >= filteredProductList.length) {
      Get.snackbar("Error", "Producto no encontrado");
      return;
    }

    Product product = filteredProductList[index];
    if (product.inventario > 0) {
      int newInventory = product.inventario - 1;
      await _updateInventory(product, newInventory);
    } else {
      Get.snackbar("Aviso", "El inventario no puede ser menor que cero");
    }
  }

  Future<void> updateInventoryDirectly(int index, String value) async {
    if (index < 0 || index >= filteredProductList.length) {
      Get.snackbar("Error", "Producto no encontrado");
      return;
    }

    int? newInventory = int.tryParse(value);
    if (newInventory != null && newInventory >= 0) {
      Product product = filteredProductList[index];
      await _updateInventory(product, newInventory);
    } else {
      Get.snackbar("Error", "Valor de inventario inválido");
    }
  }

  Future<void> _updateInventory(Product product, int newInventory) async {
    SqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();

    try {
      int rowsAffected = await db.update(
        'ProductosCatalogo',
        {'inventario': newInventory},
        where: 'Codigo = ?',
        whereArgs: [product.codigo],
      );

      if (rowsAffected > 0) {
        int filteredIndex = filteredProductList.indexWhere((p) => p.codigo == product.codigo);
        if (filteredIndex != -1) {
          filteredProductList[filteredIndex] = product.copyWith(inventario: newInventory);
        }

        int originalIndex = productList.indexWhere((p) => p.codigo == product.codigo);
        if (originalIndex != -1) {
          productList[originalIndex] = product.copyWith(inventario: newInventory);
        }

        update(); // Notifica a los widgets que usan este controlador que deben actualizarse
      } else {
        Get.snackbar("Error", "No se encontró el producto para actualizar");
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo actualizar el inventario");
    }
  }
}

// Asegúrate de que esta extensión esté definida en tu archivo product.dart
extension ProductExtension on Product {
  Product copyWith({
    int? inventario,
    // Añade aquí otros campos que puedan necesitar actualizarse
  }) {
    return Product(
      agrupacion: this.agrupacion,
      archivo: this.archivo,
      bodega: this.bodega,
      categoria: this.categoria,
      cenExt2: this.cenExt2,
      clave: this.clave,
      codigo: this.codigo,
      core: this.core,
      ean: this.ean,
      gm4: this.gm4,
      grupo: this.grupo,
      itf: this.itf,
      iva: this.iva,
      linea: this.linea,
      lineaproduccion: this.lineaproduccion,
      marca: this.marca,
      nombre: this.nombre,
      pagaPastilla: this.pagaPastilla,
      peso: this.peso,
      portafolio: this.portafolio,
      precio: this.precio,
      saldo: this.saldo,
      sector: this.sector,
      subcategoria: this.subcategoria,
      sublinea: this.sublinea,
      unidades: this.unidades,
      unidadesxcaja: this.unidadesxcaja,
      unidadmedida: this.unidadmedida,
      vendedor: this.vendedor,
      marcadd: this.marcadd,
      createAt: this.createAt,
      inventario: inventario ?? this.inventario,
    );
  }
}