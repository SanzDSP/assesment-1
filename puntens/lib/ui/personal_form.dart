// Sandi S
import 'package:flutter/material.dart';
import 'list_data.dart';

class PersonalDataForm extends StatefulWidget {
  @override
  _PersonalDataFormState createState() => _PersonalDataFormState();
}

class _PersonalDataFormState extends State<PersonalDataForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  DateTime? _selectedDate;
  bool isPhoneNumberValid = false;
  bool isVerificationDone = false;
  bool agreeToTerms = false;

  List<Map<String, String>>? data = [];

  void _saveData() {
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String id = _idController.text;
    String address = _addressController.text;
    String birthDate = _selectedDate != null
        ? "${_selectedDate}".split(' ')[0] //.toLocal()
        : "Belum Dipilih";

    data?.add({
      'Name': name,
      'Email': email,
      'Phone': phone,
      'Id': id,
      'Address': address,
      'BirthDate': birthDate
    });

    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _idController.clear();
    _addressController.clear();
    setState(() {
      _selectedDate = null;
      isPhoneNumberValid = false;
    });
  }

  void _viewData() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PersonalDataDisplay(
          data: data,
          clearData: _clearData,
        ),
      ),
    );
  }

  void _clearData() {
    setState(() {
      data?.clear();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PERSONAL FORM",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Full Name',
              style: TextStyle(
                color: Color(0xFF2A2A2A),
                fontSize: 14,
                fontFamily: 'Chive',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter FullName',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff2A2A2A), // Set the border color to #2A2A2A
                    width: 2.0,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 10.0,
                ),
              ),
            ),
            SizedBox(height: 20),
            const Text(
              'Email',
              style: TextStyle(
                color: Color(0xFF2A2A2A),
                fontSize: 14,
                fontFamily: 'Chive',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Enter your Email',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff2A2A2A), // Set the border color to #2A2A2A
                    width: 2.0,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 10.0,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    onChanged: (text) {
                      setState(() {
                        isPhoneNumberValid = text.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff2A2A2A),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 10.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 48.0,
                  child: ElevatedButton(
                    onPressed: isPhoneNumberValid
                        ? () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Verification'),
                                    content: Text('Verification Berhasil'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Close'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                            setState(() {
                              isVerificationDone =
                                  true; // Set verifikasi selesai menjadi true
                            });
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Color(0xff4a3de5),
                      side: BorderSide(
                        color: Color(0xff4a3de5),
                      ),
                    ),
                    child: Text('Verify'),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Phone Number is Valid: ',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 10),
                if (isVerificationDone)
                  Icon(Icons.check,
                      color: Colors
                          .green), // Tampilkan ikon jika verifikasi sudah dilakukan
                Visibility(
                  visible: false, // Checkbox tidak akan ditampilkan
                  child: Checkbox(
                    value: isPhoneNumberValid,
                    onChanged: (bool? value) {
                      setState(() {
                        isPhoneNumberValid = value ?? false;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Personal ID Number',
              style: TextStyle(
                color: Color(0xFF2A2A2A),
                fontSize: 14,
                fontFamily: 'Chive',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'value',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff2A2A2A), // Set the border color to #2A2A2A
                    width: 2.0,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 10.0,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Address',
              style: TextStyle(
                color: Color(0xFF2A2A2A),
                fontSize: 14,
                fontFamily: 'Chive',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Enter your text here',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff2A2A2A), // Set the border color to #2A2A2A
                    width: 2.0,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 10.0,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Choose a Date',
              style: TextStyle(
                color: Color(0xFF2A2A2A),
                fontSize: 14,
                fontFamily: 'Chive',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff2A2A2A)),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width *
                      0.9, // Mengatur panjang sesuai dengan lebar layar
                  child: Row(
                    children: <Widget>[
                      Text(
                        _selectedDate != null
                            ? " ${_selectedDate?.day}/${_selectedDate?.month}/${_selectedDate?.year}"
                            : 'Select date',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Spacer(), // Spacer akan memindahkan ikon ke kanan
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Checkbox(
                  value: agreeToTerms,
                  onChanged: (bool? value) {
                    setState(() {
                      agreeToTerms = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: _saveData,
                  child: Text('Simpan'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _viewData,
                  child: Text('Lihat Data'),
                ),
              ],
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.list), // Icon list
              //title: Text('Lihat Data'),
              onTap: () {
                Navigator.of(context).pop(); // Tutup end drawer
                _viewData(); // Panggil fungsi untuk melihat data
              },
            ),
          ],
        ),
      ),
    );
  }
}
