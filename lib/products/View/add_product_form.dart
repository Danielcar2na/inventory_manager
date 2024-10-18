import 'package:flutter/material.dart';
import 'package:flutter_application_1/products/model/product.dart';
import 'package:flutter_application_1/products/view_model/product_view_model.dart';
import 'package:get/get.dart';

class AddProductForm extends StatelessWidget {
  final viewModel = Get.find<ProductViewModel>();

  AddProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    // Controladores para los campos de texto
    TextEditingController nombreController = TextEditingController();
    TextEditingController precioController = TextEditingController();

    // Aquí almacenaremos el código autoincremental del producto
    int nextCodigo = 1;

    // Función para obtener el código del último producto y sumarle 1
    Future<void> getNextCodigo() async {
      // Obtener el último producto de la base de datos
      Product? lastProduct = await viewModel.getLastProduct();
      // Si hay productos, tomar el código del último y sumarle 1
      if (lastProduct != null) {
        nextCodigo = int.parse(lastProduct.codigo) + 1;
      }
    }

    return ElevatedButton(
      onPressed: () async {
        await getNextCodigo(); // Obtener el próximo código disponible

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
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          confirm: ElevatedButton(
            onPressed: () {
              // Crear un nuevo objeto Product con los datos del formulario
              Product newProduct = Product(
                agrupacion: 'Nuevo', // Añadir valores fijos o controladores
                archivo: '',
                bodega: '',
                categoria: '',
                cenExt2: '',
                clave: '',
                codigo: nextCodigo.toString(), // Asignar el código autoincremental
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
                precio: double.parse(precioController.text),
                saldo: 0,
                sector: '',
                subcategoria: '',
                sublinea: '',
                unidades: '',
                unidadesxcaja: '',
                unidadmedida: '',
                vendedor: '',
                marcadd: '',
              );

              // Llamar al método para agregar el producto a la base de datos
              viewModel.addProduct(newProduct);

              // Limpiar los campos del formulario
              nombreController.clear();
              precioController.clear();

              // Cerrar el diálogo
              Get.back();
            },
            child: const Text("Agregar"),
          ),
          cancel: ElevatedButton(
            onPressed: () {
              Get.back(); // Cerrar el diálogo
            },
            child: const Text("Cancelar"),
          ),
        );
      },
      child: const Text("Agregar Producto"),
    );
  }
}
