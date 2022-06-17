import 'package:flutter/material.dart';
import 'package:flutter_curso/src/models/user.dart';
import 'package:flutter_curso/src/pages/home/home_page.dart';
import 'package:flutter_curso/src/pages/login/login_page.dart';
import 'package:flutter_curso/src/pages/register/register_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

User userSession = User.fromJson(GetStorage().read('user') ?? {});

void main() async {
  // MANEJO DE STORAGE
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Delivery',
      debugShowCheckedModeBanner: false,
      initialRoute: userSession.id != null ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.amber,
          secondary: Colors.amberAccent,
          onPrimary: Colors.grey,
          onSecondary: Colors.grey,
          onBackground: Colors.grey,
          surface: Colors.grey,
          onSurface: Colors.grey,
          error: Colors.grey,
          onError: Colors.grey,
          background: Colors.grey,
        ),
      ),
      navigatorKey: Get.key,
    );
  }
}
