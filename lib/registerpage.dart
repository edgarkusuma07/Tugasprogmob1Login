import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progmob_1/homepage.dart';

class Register extends StatelessWidget {
  const Register({super.key});

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
              decoration: InputDecoration(
                labelText: 'No.Telepon',
                labelStyle: const TextStyle(color: Colors.black),
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0), width: 2),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Masukan Nama Lengkap',
                labelStyle: const TextStyle(color: Colors.black),
                fillColor: const Color.fromARGB(255, 255, 254, 254),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0), width: 2),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.black),
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: const HomePage(),
                            type: PageTransitionType.fade));
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
