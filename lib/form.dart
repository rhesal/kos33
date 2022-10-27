// ignore_for_file: unnecessary_new, unused_field, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_import, use_key_in_widget_constructors, avoid_print, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'alert_dialog.dart';

class FormPage extends StatefulWidget {
  //constructor have one parameter, optional paramter
  //if have id we will show data and run update method
  //else run add data
  const FormPage({this.id});

  final String? id;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  //set form key
  final _formKey = GlobalKey<FormState>();

  //set texteditingcontroller variable
  var namaController = TextEditingController();
  var nikController = TextEditingController();
  var ttlController = TextEditingController();
  var noHpController = TextEditingController();
  var alamatController = TextEditingController();
  var pekerjaanController = TextEditingController();
  var alamatPekerjaanController = TextEditingController();
  var tglMasukController = TextEditingController();
  var noKamarController = TextEditingController();
  var hargaKamarController = TextEditingController();
  var tglKeluarController = TextEditingController();

  bool tappedYes = false;

  //inisialize firebase instance
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  CollectionReference? users;

  void getData() async {
    //get users collection from firebase
    //collection is table in mysql
    users = firebase.collection('users');

    //if have id
    if (widget.id != null) {
      //get users data based on id document
      var data = await users!.doc(widget.id).get();

      //we get data.data()
      //so that it can be accessed, we make as a map
      var item = data.data() as Map<String, dynamic>;

      //set state to fill data controller from data firebase
      setState(() {
        namaController = TextEditingController(text: item['nama']);
        nikController = TextEditingController(text: item['nik']);
        ttlController = TextEditingController(text: item['ttl']);
        noHpController = TextEditingController(text: item['noHp']);
        alamatController = TextEditingController(text: item['alamat']);
        pekerjaanController = TextEditingController(text: item['pekerjaan']);
        alamatPekerjaanController =
            TextEditingController(text: item['alamatPekerjaan']);
        tglMasukController = TextEditingController(text: item['tglMasuk']);
        noKamarController = TextEditingController(text: item['noKamar']);
        hargaKamarController = TextEditingController(text: item['hargaKamar']);
        tglKeluarController = TextEditingController(text: item['tglKeluar']);
      });
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Biodata"),
          backgroundColor: Colors.amber[900],
          actions: [
            //if have data show delete button
            widget.id != null
                ? IconButton(
                    onPressed: () async {
                      final action = await AlertDialogs.yesCancelDialog(
                          context,
                          'Delete',
                          'Apakah anda yakin akan menghapus data a.n. ${namaController.text} ?');
                      if (action == DialogAction.yes) {
                        //setState(() => tappedYes = true);
                        //method to delete data based on id
                        users!.doc(widget.id).delete();
                        //back to main page
                        // '/' is home
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/', (Route<dynamic> route) => false);
                      } else {
                        setState(() => tappedYes = false);
                      }
                    },
                    icon: Icon(Icons.delete))
                : SizedBox()
          ],
        ),
        //this form for add and edit data
        //if have id passed from main, field will show data
        body: Form(
          key: _formKey,
          child: ListView(padding: EdgeInsets.all(16.0), children: [
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.amber[900],
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 30,
              ),
            ),
            Text(
              'Nama',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: namaController,
              decoration: InputDecoration(
                  hintText: "Nama",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Nama harus diisi!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Text(
              'NIK',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: nikController,
              decoration: InputDecoration(
                  hintText: "NIK",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'NIK harus diisi!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Text(
              'Tempat, Tanggal Lahir',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: ttlController,
              decoration: InputDecoration(
                  hintText: "Tempat, Tanggal Lahir",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'TTL harus diisi!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Text(
              'No.Handphone',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: noHpController,
              decoration: InputDecoration(
                  hintText: "No.Handphone",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'No.Handphone harus diisi!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Text(
              'Alamat',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: alamatController,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: null,
              decoration: InputDecoration(
                  hintText: "Alamat",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Alamat harus diisi!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Text(
              'Pekerjaan',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: pekerjaanController,
              decoration: InputDecoration(
                  hintText: "Pekerjaan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Pekerjaan harus diisi!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Text(
              'Alamat Pekerjaan',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: alamatPekerjaanController,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: null,
              decoration: InputDecoration(
                  hintText: "Alamat Pekerjaan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Alamat Pekerjaan harus diisi!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Text(
              'Tanggal Masuk',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: tglMasukController,
              decoration: InputDecoration(
                  hintText: "Tanggal Masuk",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Tgl.Masuk harus diisi!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Text(
              'No.Kamar',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: noKamarController,
              decoration: InputDecoration(
                  hintText: "No.Kamar",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'No.Kamar harus diisi!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Text(
              'Harga Kamar',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: hargaKamarController,
              decoration: InputDecoration(
                  hintText: "Harga Kamar",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Harga Kamar harus diisi!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Text(
              'Tanggal Keluar',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: tglKeluarController,
              decoration: InputDecoration(
                  hintText: "Tanggal Keluar",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  fillColor: Colors.white,
                  filled: true),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  //if id not null run add data to store data into firebase
                  //else update data based on id
                  if (widget.id == null) {
                    users!.add({
                      'nama': namaController.text,
                      'nik': nikController.text,
                      'ttl': ttlController.text,
                      'noHp': noHpController.text,
                      'alamat': alamatController.text,
                      'pekerjaan': pekerjaanController.text,
                      'alamatPekerjaan': alamatPekerjaanController.text,
                      'tglMasuk': tglMasukController.text,
                      'noKamar': noKamarController.text,
                      'hargaKamar': hargaKamarController.text,
                      'tglKeluar': tglKeluarController.text
                    });
                  } else {
                    users!.doc(widget.id).update({
                      'nama': namaController.text,
                      'nik': nikController.text,
                      'ttl': ttlController.text,
                      'noHp': noHpController.text,
                      'alamat': alamatController.text,
                      'pekerjaan': pekerjaanController.text,
                      'alamatPekerjaan': alamatPekerjaanController.text,
                      'tglMasuk': tglMasukController.text,
                      'noKamar': noKamarController.text,
                      'hargaKamar': hargaKamarController.text,
                      'tglKeluar': tglKeluarController.text
                    });
                  }
                  //snackbar notification
                  final snackBar =
                      SnackBar(content: Text('Data saved successfully!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  //back to main page
                  //home page => '/'
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                }
              },
            )
          ]),
        ));
  }
}
