import 'package:flutter/material.dart';
import 'package:flutter_application_1/products/view_model/product_view_model.dart';
import 'package:get/get.dart';
import '../view_model/home_view_model.dart';

class UserItemList extends StatelessWidget {
  UserItemList({Key? key, required this.position}) : super(key: key);

  final viewModel = Get.find<HomeViewModel>();
  final viewModelProduct = Get.put<ProductViewModel>(ProductViewModel());
  final int position;

  @override
  Widget build(BuildContext context) {
    // Verificar si el índice `position` está dentro del rango de la lista
    if (position < 0 || position >= viewModel.clientList.length) {
      // Si el índice está fuera de rango, mostrar un mensaje o un widget vacío
      return const SizedBox.shrink(); // Esto no muestra nada si el índice es inválido
    }

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
                '${viewModel.clientList[position].nombre!} - ${viewModel.clientList[position].nombres!} ${viewModel.clientList[position].apellidos!}',
              ),
              Text(
                viewModel.clientList[position].codigo!,
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
                viewModel.clientList[position].telefono!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
