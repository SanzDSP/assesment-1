// Sandi S
import 'package:flutter/material.dart';

class PersonalDataDisplay extends StatelessWidget {
  final List<Map<String, String>>? data;
  final VoidCallback clearData;

  PersonalDataDisplay({required this.data, required this.clearData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Personal'),
      ),
      body: ListView.builder(
        itemCount: data?.length,
        itemBuilder: (context, index) {
          final item = data?[index];
          return Container(
            margin: EdgeInsets.all(
                10.0), // Margin untuk menambahkan ruang di sekitar setiap item
            padding: EdgeInsets.all(
                10.0), // Padding untuk memberikan jarak dari tepi border
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black), // Border hitam
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama: ${item?['Name']}',
                  style: TextStyle(fontWeight: FontWeight.bold), // Teks tebal
                ),
                Text(
                  'Email: ${item?['Email']}',
                  style: TextStyle(color: Colors.blue), // Warna teks biru
                ),
                Text('Address: ${item?['Address']}'),
                // Text('Tanggal Lahir: ${item?['BirthDate']}'),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: clearData,
        child: Text('Hapus Data'),
      ),
    );
  }
}
