import 'package:flutter/material.dart';
import 'package:flutter_application_1/products/model/product.dart';
import 'package:flutter_application_1/products/view_model/product_view_model.dart';
import 'package:get/get.dart';

class AddProductForm extends StatelessWidget {
  final viewModel = Get.find<ProductViewModel>();

  AddProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nombreController = TextEditingController();
    TextEditingController precioController = TextEditingController();
    TextEditingController inventarioController = TextEditingController();

    return ElevatedButton(
      onPressed: () async {
        int nextCodigo = await viewModel.getNextCodigo();

        Get.defaultDialog(
          title: "Agregar Producto",
          content: Column(
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: "Nombre"),
              ),
              TextField(
                controller: precioController,
                decoration: const InputDecoration(labelText: "Precio"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: inventarioController,
                decoration: const InputDecoration(labelText: "Cantidad en Inventario"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          confirm: ElevatedButton(
            onPressed: () {
              if (nombreController.text.isEmpty || precioController.text.isEmpty || inventarioController.text.isEmpty) {
                Get.snackbar(
                  "Error",
                  "Por favor, complete todos los campos",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }

              double? precio = double.tryParse(precioController.text);
              int? inventario = int.tryParse(inventarioController.text);
              if (precio == null || inventario == null) {
                Get.snackbar(
                  "Error",
                  "Por favor, ingrese valores válidos para precio e inventario",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }

              Product newProduct = Product(
                agrupacion: 'Nuevo',
                archivo: '',
                bodega: '',
                categoria: '',
                cenExt2: '',
                clave: '',
                codigo: nextCodigo.toString(),
                core: '',
                ean: '',
                gm4: '',
                grupo: '',
                itf: '',
                iva: 0,
                linea: '',
                lineaproduccion: '',
                marca: '',
                nombre: nombreController.text,
                pagaPastilla: '',
                peso: 0.0,
                portafolio: '',
                precio: precio,
                saldo: 0,
                sector: '',
                subcategoria: '',
                sublinea: '',
                unidades: '',
                unidadesxcaja: '',
                unidadmedida: '',
                vendedor: '',
                marcadd: '',
                createAt: DateTime.now(),
                inventario: inventario,
              );

              viewModel.addProduct(newProduct);

              nombreController.clear();
              precioController.clear();
              inventarioController.clear();

              Get.back();
            },
            child: const Text("Agregar"),
          ),
          cancel: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancelar"),
          ),
        );
      },
      child: const Text("Agregar Producto"),
    );
  }
}