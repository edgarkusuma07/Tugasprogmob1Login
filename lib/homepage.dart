import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
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
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  goUser(dio, myStorage, apiUrl);
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
                child: const Text('Cek User',
                    style: TextStyle(color: Colors.black))),
          ],
        ),
      ),
    );
  }
}

void goUser(dio, myStorage, apiUrl) async {
  try {
    final response = await dio.get(
      '$apiUrl/user',
      options: Options(
        headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
      ),
    );
    print(response.data);
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}
