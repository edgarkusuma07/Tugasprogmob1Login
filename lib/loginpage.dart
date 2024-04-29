import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progmob_1/homepage.dart';
import 'package:progmob_1/registerpage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 148, 241, 151),
      appBar: AppBar(
        title: const Text('Halaman Login'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(height: 30),

              // Email
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.black),
                    fillColor: Colors.grey,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.green, width: 2),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),

              // Passowrd
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.grey,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Login
              ElevatedButton(
                  onPressed: () {
                    goLogin(context, dio, myStorage, apiUrl, emailController,
                        passwordController);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color.fromARGB(255, 14, 95, 161),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: Colors.green[300],
                  ),
                  child: const Text('Masuk',
                      style: TextStyle(color: Colors.black))),

              const SizedBox(height: 10),

              // Daftar
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: Register(), type: PageTransitionType.fade));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color.fromARGB(255, 14, 95, 161),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: Colors.green[300],
                  ),
                  child: const Text('Daftar?',
                      style: TextStyle(color: Colors.black))),
            ],
          ),
        ),
      ),
    );
  }
}

void goLogin(BuildContext context, dio, myStorage, apiUrl, emailController,
    passwordController) async {
  try {
    final response = await dio.post(
      '$apiUrl/login',
      data: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );
    print(response.data);
    Navigator.push(context,
        PageTransition(child: const HomePage(), type: PageTransitionType.fade));
    myStorage.write('token', response.data['data']['token']);
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}
