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
        title: Text('Form Data Personal'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Enter FullName'),
            ),
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
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Enter your Email'),
            ),
            // TextField(
            //   controller: _phoneController,
            //   decoration: InputDecoration(labelText: 'Enter phone number'),
            // ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _phoneController,
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
                    width:
                        10), // Add some space between TextField and Verify button
                ElevatedButton(
                  onPressed: () {
                    // Add your verification logic here
                    // For example, show a dialog or perform an action
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
                      },
                    );
                    // Assuming verification is successful, update the state
                    setState(() {
                      isPhoneNumberValid = true;
                    });
                  },
                  child: Text('Verify',
                      style: TextStyle(color: Color(0xff4a3de5))),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Text(
                  'Phone Number is Valid: ',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 10), // Add some space between text and checkbox
                if (isPhoneNumberValid)
                  Icon(Icons.check,
                      color: Colors.green), // Show check icon if valid
                Checkbox(
                  value: isPhoneNumberValid,
                  onChanged: (bool? value) {
                    setState(() {
                      isPhoneNumberValid = value ?? false;
                    });
                  },
                ),
              ],
            ),
            const Text(
              'Personal ID Number',
              style: TextStyle(
                color: Color(0xFF2A2A2A),
                fontSize: 14,
                fontFamily: 'Chive',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'value'),
            ),
            const Text(
              'Address',
              style: TextStyle(
                color: Color(0xFF2A2A2A),
                fontSize: 14,
                fontFamily: 'Chive',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Enter your text here'),
            ),
            const Text(
              'Choose a Date',
              style: TextStyle(
                color: Color(0xFF2A2A2A),
                fontSize: 14,
                fontFamily: 'Chive',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            ListTile(
              title: Text("Choose a Date"),
              subtitle: _selectedDate == null
                  ? Text("Select date")
                  : Text("${_selectedDate}".split(' ')[0]), //.toLocal()
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
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
          ],
        ),
      ),
      //endDrawer: _buildDrawerKanan(),
    );
  }
}

// class PersonalDataForm extends StatefulWidget {
//   @override
//   _PersonalDataFormState createState() => _PersonalDataFormState();
// }

// class _PersonalDataFormState extends State<PersonalDataForm> {
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _idController = TextEditingController();
//   TextEditingController _phoneController = TextEditingController();
//   TextEditingController _addressController = TextEditingController();
//   DateTime? _selectedDate;

//   void _saveDataAndNavigate(BuildContext context) {
//     // Simpan data ke variabel yang akan ditampilkan
//     String name = _nameController.text;
//     String email = _emailController.text;
//     String phone = _phoneController.text;
//     String id = _idController.text;
//     String address = _addressController.text;
//     String birthDate = _selectedDate != null
//         ? "${_selectedDate}".split(' ')[0]
//         //.toLocal()
//         : "Belum Dipilih";

//     // Pindah ke laman selanjutnya dan kirim data
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PersonalDataDisplay(
//           name: name,
//           email: email,
//           id: id,
//           phone: phone,
//           address: address,
//           birthDate: birthDate,
//         ),
//       ),
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Form Data Personal'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Enter FullName'),
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Enter your Email'),
//             ),
//             TextField(
//               controller: _phoneController,
//               decoration: InputDecoration(labelText: 'Enter phone number'),
//             ),
//             TextField(
//               controller: _idController,
//               decoration: InputDecoration(labelText: 'value'),
//             ),
//             TextField(
//               controller: _addressController,
//               decoration: InputDecoration(labelText: 'Enter your text here'),
//             ),
//             ListTile(
//               title: Text("Tanggal Lahir"),
//               subtitle: _selectedDate == null
//                   ? Text("Pilih Tanggal")
//                   : Text("${_selectedDate}".split(' ')[0]),
//               //.toLocal()
//               trailing: Icon(Icons.calendar_today),
//               onTap: () => _selectDate(context),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _saveDataAndNavigate(context);
//               },
//               child: Text('Simpan'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
