import 'package:flutter/material.dart';
import 'package:flutter_application_1/products/model/product.dart';
import 'package:get/get.dart';
import '../view_model/product_view_model.dart';
import 'package:intl/intl.dart';

class ProductItemList extends StatelessWidget {
  final Product product;
  final int index;

  ProductItemList({Key? key, required this.product, required this.index}) : super(key: key);

  final viewModel = Get.find<ProductViewModel>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          '${product.nombre} - ${product.codigo}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).primaryColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Precio: \$${product.precio.toStringAsFixed(2)}'),
            Text('Fecha: ${DateFormat('dd/MM/yyyy').format(product.createAt)}'),
            Text('Categoría: ${product.categoria}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _showEditDialog(context),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showDeleteConfirmation(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    TextEditingController nombreController = TextEditingController(text: product.nombre);
    TextEditingController precioController = TextEditingController(text: product.precio.toString());
    DateTime selectedDate = product.createAt;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Producto'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nombreController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: precioController,
                  decoration: InputDecoration(labelText: 'Precio'),
                  keyboardType: TextInputType.number,
                ),
                ListTile(
                  title: Text('CreateAt: ${DateFormat('dd/MM/yyyy').format(selectedDate)}'),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != selectedDate) {
                      selectedDate = picked;
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                Product updatedProduct = Product(
                  agrupacion: product.agrupacion,
                  archivo: product.archivo,
                  bodega: product.bodega,
                  categoria: product.categoria,
                  cenExt2: product.cenExt2,
                  clave: product.clave,
                  codigo: product.codigo,
                  core: product.core,
                  ean: product.ean,
                  gm4: product.gm4,
                  grupo: product.grupo,
                  itf: product.itf,
                  iva: product.iva,
                  linea: product.linea,
                  lineaproduccion: product.lineaproduccion,
                  marca: product.marca,
                  nombre: nombreController.text,
                  pagaPastilla: product.pagaPastilla,
                  peso: product.peso,
                  portafolio: product.portafolio,
                  precio: double.parse(precioController.text),
                  saldo: product.saldo,
                  sector: product.sector,
                  subcategoria: product.subcategoria,
                  sublinea: product.sublinea,
                  unidades: product.unidades,
                  unidadesxcaja: product.unidadesxcaja,
                  unidadmedida: product.unidadmedida,
                  vendedor: product.vendedor,
                  marcadd: product.marcadd,
                  createAt: selectedDate,
                );
                viewModel.editProduct(index, updatedProduct);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: Text('¿Está seguro de que desea eliminar este producto?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                viewModel.deleteProduct(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}