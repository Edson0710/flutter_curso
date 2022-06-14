import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: _textDontHaveAccount(),
      ),
      body: Stack( // POSICIONAR ELEMENTOS UNO ENCIMA DEL OTRO
        children: [
          _backgroundCover(context),
          Column( // POSICIONAR ELEMENTOS UNO DEBAJO DEL OTRO (VERTICAL)
            children: [
              _imageCover(),
              _textAppName(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _backgroundCover(BuildContext context){
    return Container(
      width: double.infinity, //TODA LA PANTALLA
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.amber,
    );
  }

  Widget _textAppName(){
    return Text(
      'DELIVERY MYSQL',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _textDontHaveAccount(){
    return Row( // UBICAR ELEMENTOS UNO AL LADO DEL OTRO (HORIZONTAL)
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿No tienes cuenta?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        SizedBox(width: 7), // SEPARAR
        Text(
          'Registrate Aquí',style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ],
    );
  }

  // PRIVATE WIDGET
  Widget _imageCover(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 15),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/img/delivery.png',
          width: 130,
          height: 130,
        ),
      ),
    );
  }
}