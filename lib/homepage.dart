import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progmob_1/AddUser.dart';
import 'package:progmob_1/list_transaksi.dart';
import 'package:progmob_1/list_user.dart';
import 'package:progmob_1/loginpage.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Transaksi'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'List User'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Navigasi ke halaman Home
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 1:
              // Navigasi ke halaman Anggota
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListTransaksi()),
              );
              break;
            case 2:
              // Navigasi ke halaman Wallet
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListUser()),
              );
              break;
          }
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(221, 248, 45, 102),
              Color.fromARGB(255, 51, 120, 177),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black87, Colors.grey],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: const Text(
                  'Selamat Datang di Home Page',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CardButton(
                onPressed: () {
                  goUser(dio, myStorage, apiUrl);
                },
                label: 'Cek User',
                icon: Icons.person,
              ),
              const SizedBox(
                height: 10,
              ),
              CardButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: AddUser(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                label: 'Tambah User',
                icon: Icons.person_add,
              ),
              const SizedBox(
                height: 10,
              ),
              CardButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: ListUser(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                label: 'Cek Daftar User',
                icon: Icons.people,
              ),
              const SizedBox(
                height: 10,
              ),
              CardButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: ListTransaksi(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                label: 'Transaksi Anggota',
                icon: Icons.attach_money,
              ),
              const SizedBox(
                height: 10,
              ),
              CardButton(
                onPressed: () {
                  goLogout(context, dio, myStorage, apiUrl);
                },
                label: 'Logout',
                icon: Icons.exit_to_app,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  const CardButton({
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(
            color: Color.fromARGB(255, 255, 255, 255),
            width: 2,
          ),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: Colors.white),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Opacity(
                  opacity: 0,
                  child: Icon(icon),
                ),
              ],
            ),
          ),
        ),
        color: Color.fromARGB(255, 0, 0, 0),
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

void goLogout(BuildContext context, dio, myStorage, apiUrl) async {
  try {
    final response = await dio.get(
      '$apiUrl/logout',
      options: Options(
        headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
      ),
    );
    print(response.data);

    // Hapus token setelah logout
    await myStorage.erase();

    // Navigasi ke halaman login
    Navigator.pushReplacement(
      context,
      PageTransition(child: LoginPage(), type: PageTransitionType.fade),
    );
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}
