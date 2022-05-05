import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed("/new");
    });
    return Scaffold(
      body: Center(
        child: Text(
          'Pranesh Tech Apps',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
