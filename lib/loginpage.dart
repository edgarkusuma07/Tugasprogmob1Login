import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progmob_1/homepage.dart';
import 'package:progmob_1/registerpage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkLoginStatus();
    });
  }

  void checkLoginStatus() {
    final token = myStorage.read('token');
    if (token != null) {
      // Jika pengguna sudah login, arahkan ke halaman login page
      Navigator.push(
        context,
        PageTransition(
          child: HomePage(),
          type: PageTransitionType.fade,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: Color.fromARGB(255, 0, 0, 0),
            child: const Text(
              'Halaman Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      width: 300,
                      child: const Text(
                        'Sudah memiliki akun? silahkan masuk',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Email
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Colors.black),
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0), width: 2),
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
                        fillColor: const Color.fromARGB(255, 255, 253, 253),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Login
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                          onPressed: () {
                            goLogin(context, dio, myStorage, apiUrl,
                                emailController, passwordController);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                          child: const Text('Masuk',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)))),
                    ),

                    const SizedBox(height: 10),

                    // Daftar
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: Register(),
                                    type: PageTransitionType.fade));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          child: const Text('Daftar?',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
