import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progmob_1/homepage.dart';
import 'package:progmob_1/loginpage.dart';
import 'package:progmob_1/registerpage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => Register(),
      },
      initialRoute: '/login',
    );
  }
}
