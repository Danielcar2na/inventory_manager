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
    // Puedes añadir más controladores para otros campos...

    return ElevatedButton(
      onPressed: () {
        Get.defaultDialog(
          title: "Agregar Producto",
          content: Column(
            children: [
              TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: "Nombre"),
              ),
              TextField(
                controller: precioController,
                decoration: InputDecoration(labelText: "Precio"),
                keyboardType: TextInputType.number,
              ),
              // Añadir más campos aquí según lo necesites...
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
                codigo: 'Nuevo',
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

              // Llamar al método para agregar el producto
              viewModel.addProduct(newProduct);

              Get.back(); // Cerrar el diálogo
            },
            child: Text("Agregar Producto"),
          ),
          cancel: ElevatedButton(
            onPressed: () {
              Get.back(); // Cerrar el diálogo
            },
            child: Text("Cancelar"),
          ),
        );
      },
      child: Text("Agregar Producto"),
    );
  }
}
