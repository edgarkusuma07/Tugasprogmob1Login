import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progmob_1/list_transaksi.dart';
import 'package:progmob_1/saldo_user.dart';

class AddTransaksi extends StatefulWidget {
  final Map<String, dynamic> user;

  const AddTransaksi({
    super.key,
    required this.user,
  });

  @override
  State<AddTransaksi> createState() => _AddTransaksiState();
}

class _AddTransaksiState extends State<AddTransaksi> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  TextEditingController idAnggotaController = TextEditingController();
  TextEditingController trxNominalController = TextEditingController();
  int? selectedTrxId;

  @override
  void initState() {
    super.initState();
    idAnggotaController = TextEditingController(
      text: widget.user['id'].toString(),
    );
    selectedTrxId = 1;
  }

  void menuTransaksi() async {
    try {
      final response = await dio.post(
        '$apiUrl/tabungan',
        options: Options(
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
        data: {
          'anggota_id': idAnggotaController.text,
          'trx_id': selectedTrxId.toString(),
          'trx_nominal': trxNominalController.text,
        },
      );

      print(response.data);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SaldoUser(
            user: widget.user,
          ),
        ),
      );
    } on DioException catch (e) {
      print('Error : ${e.response?.statusCode} - ${e.response?.data}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Atas Nama: ${widget.user['nama']}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: trxNominalController,
              decoration: InputDecoration(
                labelText: 'TRX Nominal',
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
                    color: Color.fromARGB(255, 0, 0, 0),
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // Menu Transaksi
            DropdownButtonFormField(
              decoration: InputDecoration(
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
                    color: Color.fromARGB(255, 0, 0, 0),
                    width: 2,
                  ),
                ),
              ),
              items: const [
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text('Setoran Awal'),
                ),
                DropdownMenuItem<int>(
                  value: 2,
                  child: Text('Tambah Saldo'),
                ),
                DropdownMenuItem<int>(
                  value: 3,
                  child: Text('Penarikan Saldo'),
                ),
                DropdownMenuItem<int>(
                  value: 5,
                  child: Text('Koreksi Penambahan'),
                ),
                DropdownMenuItem<int>(
                  value: 6,
                  child: Text('Koreksi Pengurangan'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedTrxId = value!;
                });
              },
            ),

            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: menuTransaksi,
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
