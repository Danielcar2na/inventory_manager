import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/view_model/home_view_model.dart';
import 'package:flutter_application_1/home/widgets/user_item_list.dart';
import 'package:flutter_application_1/login/model/seller.dart';
import 'package:flutter_application_1/products/View/product_screen.dart';
import 'package:flutter_application_1/products/view_model/product_view_model.dart';
import 'package:flutter_application_1/shared/widgets/custom_button.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final viewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Clientes'),
            actions: [
              _CustomBottom(),
            ],
          ),
          backgroundColor: const Color.fromARGB(223, 255, 255, 255),
          body: Column(
            children: [
              Obx(() => SingleChildScrollView(
                    controller: viewModel.scrollController,
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: Get.width,
                      width: Get.width * 0.95,
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 0.5),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: false,
                        itemCount: viewModel.clientList.length,
                        itemBuilder: (BuildContext context, int position) {
                          return UserItemList(position: position);
                        },
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}

class _CustomBottom extends StatelessWidget {
  const _CustomBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
    style: ButtonStyle(

    ),
    onPressed: () {
       Get.to(() => ProductScreen());
    },
     child: Text('Ir a productos'),);
  }
}

Widget card1(Seller seller) {
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
                'Hola, ${seller.nombre}',
              ),
              Text(
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  'Bienvenido')
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
          'res/images/logo_azul.png',
          width: 180,
        ),
      ],
    ),
  );
}
