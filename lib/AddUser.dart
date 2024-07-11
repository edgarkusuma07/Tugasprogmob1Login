import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progmob_1/homepage.dart';
import 'package:progmob_1/list_user.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  TextEditingController noIndukController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController tglLahirController = TextEditingController();
  TextEditingController teleponController = TextEditingController();

  void addUser() async {
    try {
      final response = await dio.post(
        '$apiUrl/anggota',
        options: Options(
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
        data: {
          'nomor_induk': noIndukController.text,
          'nama': namaController.text,
          'alamat': alamatController.text,
          'tgl_lahir': tglLahirController.text,
          'telepon': teleponController.text,
        },
      );
      print(response.data);

      // Pindah halaman ke home jika berhasil tambah user
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ListUser()),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        showAlertDialog(context, 'Error', 'Nomor Induk sudah ada!');
      } else {
        print('${e.response} - ${e.response?.statusCode}');
      }
    }
  }

  void showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin menyimpan data ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                addUser();
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Tambahkan Data Anggota',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: noIndukController,
              decoration: InputDecoration(
                labelText: 'Nomor Induk',
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
              controller: namaController,
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
              controller: alamatController,
              decoration: InputDecoration(
                labelText: 'Alamat',
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
              controller: tglLahirController,
              decoration: InputDecoration(
                labelText: 'Tanggal Lahir',
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
              controller: teleponController,
              decoration: InputDecoration(
                labelText: 'Telephone',
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
            ElevatedButton(
              onPressed: showConfirmDialog,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 14, 95, 161),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              ),
              child: const Text(
                'Simpan',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
