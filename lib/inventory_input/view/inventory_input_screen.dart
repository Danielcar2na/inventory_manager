import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controller/inventory_input_controller.dart';
import 'package:flutter_application_1/products/model/product.dart';

class InventoryInputScreen extends StatelessWidget {
  final InventoryInputController controller =
      Get.put(InventoryInputController());
  InventoryInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrada de Mercancía'),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => DropdownButtonFormField<Product>(
                  decoration:
                      const InputDecoration(labelText: 'Seleccionar Producto'),
                  value: controller.selectedProduct.value,
                  items: controller.products.map((Product product) {
                    return DropdownMenuItem<Product>(
                      value: product,
                      child: Text(product.nombre),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedProduct.value = value;
                  },
                )),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(labelText: 'Cantidad'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                controller.cantidad.value = int.tryParse(value) ?? 0;
              },
            ),
            const SizedBox(height: 20),
            Obx(() => DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'Razón de Entrada'),
                  value: controller.selectedReason.value.isNotEmpty
                      ? controller.selectedReason.value
                      : null,
                  items: controller.razonesEntrada.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedReason.value = value!;
                  },
                )),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(labelText: 'Número de Factura'),
              onChanged: (value) {
                controller.numeroFactura.value = value;
              },
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: controller.registrarEntrada,
                child: const Text('Registrar Entrada'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
