import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_curso/src/models/response_api.dart';
import 'package:flutter_curso/src/models/user.dart';
import 'package:flutter_curso/src/providers/users_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  void register(BuildContext context) async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (isValidForm(email, name, lastName, phone, password, confirmPassword)) {
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Registrando...');

      User user = User(
        email: email,
        name: name,
        lastName: lastName,
        phone: phone,
        password: password,
      );

      Stream stream = await usersProvider.createWithImage(user, imageFile!);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        if (responseApi.success == true) {
          GetStorage().write('user', responseApi.data); //  DATOS DEL USUARIO
          goToHomePage();
        } else {
          Get.snackbar('Error', responseApi.message ?? '');
        }
      });
    }
  }

  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false);
  }

  bool isValidForm(String email, String name, String lastName, String phone,
      String password, String confirmPassword) {
    if (email.isEmpty) {
      Get.snackbar('Formulario no v??lido', 'Debes de ingresar un correo');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no v??lido', 'El correo no es v??lido');
      return false;
    }

    if (name.isEmpty) {
      Get.snackbar('Formulario no v??lido', 'Debes de ingresar tu nombre');
      return false;
    }

    if (lastName.isEmpty) {
      Get.snackbar('Formulario no v??lido', 'Debes de ingresar tu apellido');
      return false;
    }

    if (phone.isEmpty) {
      Get.snackbar('Formulario no v??lido', 'Debes de ingresar tu tel??fono');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no v??lido', 'Debes de ingresar una password');
      return false;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar('Formulario no v??lido', 'Debes de confirmar el password');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('Formulario no v??lido', 'Los password no coinciden');
      return false;
    }

    if (imageFile == null) {
      Get.snackbar('Formulario no v??lido', 'Debes de seleccionar una imagen');
      return false;
    }

    return true;
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery);
      },
      child: Text(
        "Galer??a",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );

    Widget cameraButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.camera);
      },
      child: Text(
        "C??mara",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Selecciona una opci??n"),
      actions: [
        galleryButton,
        cameraButton,
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
