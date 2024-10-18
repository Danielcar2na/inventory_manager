import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/widgets/user_item_list.dart';
import 'package:flutter_application_1/products/View/add_product_form.dart';
import 'package:flutter_application_1/products/model/product.dart';
import 'package:flutter_application_1/products/view_model/product_view_model.dart';
import 'package:flutter_application_1/products/widgets/product_item_list.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);

  final viewModel = Get.put<ProductViewModel>(ProductViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Productos'),
          actions: [
            AddProductForm(),
          ]
        ),
          backgroundColor: const Color.fromARGB(223, 255, 255, 255),
          body: Column(
            children: [
              Obx(() => SingleChildScrollView(
                    controller: viewModel.scrollController,
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: Get.width * 1.40,
                      width: Get.width * 0.95,
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 0.5),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: false,
                        itemCount: viewModel.productList.length,
                        itemBuilder: (BuildContext context, int position) {
                          return Column(
                            children: [
                              ProductItemList(position: position),
                            ],
                          );
                        },
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}

Widget logoAzul() {
  return SizedBox(
    height: 180,
    width: 200,
    child: Column(
      children: [
        Image.asset(
          'assets/img/description.png',
          width: 180,
        ),
      ],
    ),
  );
}
