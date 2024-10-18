import 'package:flutter/material.dart';
import 'package:flutter_application_1/products/View/add_product_form.dart';
import 'package:flutter_application_1/products/view_model/product_view_model.dart';
import 'package:flutter_application_1/products/widgets/product_item_list.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);

  final viewModel = Get.put<ProductViewModel>(ProductViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Inventario'),
          actions: [
            AddProductForm(),
          ],
        ),
        backgroundColor: Colors.grey[100],
        body: Column(
          children: [
            _buildDateFilter(),
            _buildProductCount(),
            Expanded(
              child: Obx(() => ListView.builder(
                controller: viewModel.scrollController,
                itemCount: viewModel.filteredProductList.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = viewModel.filteredProductList[index];
                  return ProductItemList(
                    product: product,
                    index: index,
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateFilter() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => ElevatedButton(
              onPressed: () => _selectDate(isStartDate: true),
              child: Text(viewModel.startDate.value != null
                  ? 'Desde: ${DateFormat('dd/MM/yyyy').format(viewModel.startDate.value!)}'
                  : 'Seleccionar fecha inicial'),
            )),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Obx(() => ElevatedButton(
              onPressed: () => _selectDate(isStartDate: false),
              child: Text(viewModel.endDate.value != null
                  ? 'Hasta: ${DateFormat('dd/MM/yyyy').format(viewModel.endDate.value!)}'
                  : 'Seleccionar fecha final'),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCount() {
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        'Total de productos: ${viewModel.filteredProductList.length}',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ));
  }

  void _selectDate({required bool isStartDate}) async {
    DateTime initialDate = isStartDate
        ? viewModel.startDate.value ?? DateTime.now()
        : viewModel.endDate.value ?? DateTime.now();

    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      if (isStartDate) {
        viewModel.setStartDate(picked);
      } else {
        viewModel.setEndDate(picked);
      }
    }
  }
}