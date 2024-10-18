import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/products/model/product.dart';
import 'package:get/get.dart';
import '../view_model/product_view_model.dart';

class ProductItemList extends StatelessWidget {
  ProductItemList({Key? key, required this.position}) : super(key: key);

  final viewModel = Get.find<ProductViewModel>();
  final int position;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.7,
      height: Get.height * 0.20,
      margin: const EdgeInsets.only(top: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                style: const TextStyle(
                  color: Color.fromARGB(255, 14, 74, 165),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                '${viewModel.productList[position].nombre!} - ${viewModel.productList[position].codigo!} ${viewModel.productList[position].categoria!}',
              ),
              Text(
                viewModel.productList[position].codigo!,
                style: const TextStyle(
                  leadingDistribution: TextLeadingDistribution.proportional,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                viewModel.productList[position].precio.toString(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showEditProductForm(context, position);
                    },
                    child: Icon(Icons.edit_document),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.deleteProduct(position);
                    },
                    child: Icon(Icons.delete_forever_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showEditProductForm(BuildContext context, int index) {
    Product productToEdit = viewModel.productList[index];

    // Inicializar controladores
    TextEditingController nombreController = TextEditingController(text: productToEdit.nombre);
    TextEditingController precioController = TextEditingController(text: productToEdit.precio.toString());
    // Añadir otros controladores según sea necesario...

    // Mostrar un diálogo de edición
    Get.defaultDialog(
      title: "Editar Producto",
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
          // Añadir más campos según sea necesario...
        ],
      ),
      confirm: ElevatedButton(
        onPressed: () {
          // Crear el nuevo objeto Product
          Product updatedProduct = Product(
            agrupacion: productToEdit.agrupacion,
            archivo: productToEdit.archivo,
            bodega: productToEdit.bodega,
            categoria: productToEdit.categoria,
            cenExt2: productToEdit.cenExt2,
            clave: productToEdit.clave,
            codigo: productToEdit.codigo, // Debe ser el mismo para identificar
            core: productToEdit.core,
            ean: productToEdit.ean,
            gm4: productToEdit.gm4,
            grupo: productToEdit.grupo,
            itf: productToEdit.itf,
            iva: productToEdit.iva,
            linea: productToEdit.linea,
            lineaproduccion: productToEdit.lineaproduccion,
            marca: productToEdit.marca,
            nombre: nombreController.text,
            pagaPastilla: productToEdit.pagaPastilla,
            peso: productToEdit.peso,
            portafolio: productToEdit.portafolio,
            precio: double.parse(precioController.text),
            saldo: productToEdit.saldo,
            sector: productToEdit.sector,
            subcategoria: productToEdit.subcategoria,
            sublinea: productToEdit.sublinea,
            unidades: productToEdit.unidades,
            unidadesxcaja: productToEdit.unidadesxcaja,
            unidadmedida: productToEdit.unidadmedida,
            vendedor: productToEdit.vendedor,
            marcadd: productToEdit.marcadd,
          );

          // Llamar al método de editar
          viewModel.editProduct(index, updatedProduct);
          Get.back(); // Cerrar el diálogo
        },
        child: Text("Guardar Cambios"),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back(); // Cerrar el diálogo
        },
        child: Text("Cancelar"),
      ),
    );
  }
}
