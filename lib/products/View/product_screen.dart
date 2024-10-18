import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/widgets/user_item_list.dart';
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

Widget card1(Product product) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 15),
    width: Get.width * 0.95,
    height: Get.height * 0.25,
    child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // logoAzul(),
              Text(
                style: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                'Hola, ${product.codigo}',
              ),
              Text(
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  'Bienvenido'),
            ], // lo que se muestra en la pantalla
          ),
        )),
  );
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
