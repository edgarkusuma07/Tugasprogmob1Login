import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progmob_1/loginpage.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  Register({super.key});

  final dio = Dio();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 200,
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Masukan Data Diri',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 54,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                labelStyle: const TextStyle(color: Colors.black),
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0), width: 2),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.black),
                fillColor: const Color.fromARGB(255, 255, 254, 254),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0), width: 2),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(color: Colors.black),
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Daftar
            SizedBox(
              width: 250,
              child: ElevatedButton(
                  onPressed: () {
                    goRegister(context, dio, apiUrl, nameController,
                        emailController, passwordController);
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         child: const HomePage(),
                    //         type: PageTransitionType.fade));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color.fromARGB(255, 14, 95, 161),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  child: const Text('Masuk',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}

void goRegister(BuildContext context, dio, apiUrl, nameController,
    emailController, passwordController) async {
  try {
    final response = await dio.post(
      '$apiUrl/register',
      data: {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      },
    );
    print(response.data);
    Navigator.push(context,
        PageTransition(child: LoginPage(), type: PageTransitionType.fade));
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}
