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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(flex: 1),
                        _buildTitle(),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        _buildLogo(constraints),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        _buildUserField(),
                        SizedBox(height: 10),
                        _buildPasswordField(),
                        SizedBox(height: 20),
                        _buildLoginButton(constraints),
                        Spacer(flex: 2),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Inventory Manager',
      style: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLogo(BoxConstraints constraints) {
    return SizedBox(
      height: constraints.maxHeight * 0.2,
      child: Image.asset(
        'assets/img/description.png',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildUserField() {
    return CustomTextField(
      userEditingController: viewModel.userTextField,
      prefixIconData: Icons.person,
      hint: 'Usuario',
      maxLenght: 20,
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      userEditingController: viewModel.passwordTextField,
      prefixIconData: Icons.lock,
      hint: 'Contraseña',
      maxLenght: 20,
      obscure: true,
    );
  }

  Widget _buildLoginButton(BoxConstraints constraints) {
    return SizedBox(
      width: constraints.maxWidth * 0.8,
      child: CustomButton(
        backgroundColor: Colors.white,
        onPressed: () {
          viewModel.login();
        },
        text: 'Iniciar Sesión',
      ),
    );
  }
}