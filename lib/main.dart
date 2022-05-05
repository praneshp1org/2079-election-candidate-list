import 'package:flutter/material.dart';
import 'package:json1/pages/NewPage.dart';
import 'package:json1/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:json1/pages/hp.dart';
import 'package:json1/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: HPage(),
      getPages: [
        GetPage(name: "/", page: () => Splash()),
        GetPage(name: "/new", page: () => HPage())
      ],
    );
  }
}
