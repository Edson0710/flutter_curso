import 'package:flutter/material.dart';
import 'package:flutter_curso/src/models/user.dart';
import 'package:flutter_curso/src/providers/users_provider.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (isValidForm(email, name, lastName, phone, password, confirmPassword)) {
      User user = User(
        email: email,
        name: name,
        lastName: lastName,
        phone: phone,
        password: password,
      );

      Response response = await usersProvider.create(user);

      print("Response: ${response.body}");

      Get.snackbar(
          'Formulario válido', 'Estás listo para enviar la petición HTTP');
    }
  }

  bool isValidForm(String email, String name, String lastName, String phone,
      String password, String confirmPassword) {
    if (email.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes de ingresar un correo');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no válido', 'El correo no es válido');
      return false;
    }

    if (name.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes de ingresar tu nombre');
      return false;
    }

    if (lastName.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes de ingresar tu apellido');
      return false;
    }

    if (phone.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes de ingresar tu teléfono');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes de ingresar una password');
      return false;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes de confirmar el password');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('Formulario no válido', 'Los password no coinciden');
      return false;
    }

    return true;
  }
}
