import 'package:flutter/material.dart';
import 'package:flutter_application_1/login/view_model/login_view_model.dart';
import 'package:get/get.dart';

import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final viewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(250, 0, 0, 61),
      body: Center(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                logo(),
                campoUsuario(),
                campoContrasena(),
                btnEntrar()
              ]),
        ),
      ),
    );
  }

  Widget singIn() {
    return const Text('Sing in',
        style: TextStyle(color: Colors.white, fontSize: 35));
  }

  Widget campoUsuario() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
      child: CustomTextField(
        userEditingController: viewModel.userTextField,
        prefixIconData: Icons.person,
        hint: 'usuario',
        maxLenght: 20,
      ),
    );
  }

  Widget campoContrasena() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
        child: CustomTextField(
          userEditingController: viewModel.passwordTextField,
          prefixIconData: Icons.lock,
          hint: 'password',
          maxLenght: 20,
        ));
  }

  Widget btnEntrar() {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: Get.width,
        //height: Get.height * 0.09,
        child: Expanded(
          child: CustomButton(
              backgroundColor: Colors.white,
              onPressed: () {
                viewModel.login();
              },
              text: 'iniciar Sesion'),
        ));
  }

  Widget logo() {
    return SizedBox(
      height: 180,
      width: 200,
      child: Column(
        children: [
          Image.asset(
            'res/images/logo.png',
            width: 180,
          ),
        ],
      ),
    );
  }
}
