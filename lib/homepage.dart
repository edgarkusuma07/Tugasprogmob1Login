import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.trolley), label: 'Keranjang'),
          NavigationDestination(icon: Icon(Icons.people), label: 'Profil'),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Selamat Datang di Home Page',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 200,
            ),
            Container(
              width: 500,
              height: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/fotonya1.jpg'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
