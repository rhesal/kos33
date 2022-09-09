// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_cast, prefer_is_empty
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'form.dart';

void main() async {
  //do initialization to use firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
      //remove the debug banner
      debugShowCheckedModeBanner: false,
      title: "Flutter Contact Firebase",
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //The entry point for accessing a [FirebaseFirestore].
    FirebaseFirestore firebase = FirebaseFirestore.instance;

    //get collection from firebase, collection is table in mysql
    CollectionReference users = firebase.collection('users');

    return Scaffold(
      appBar: AppBar(
        //make appbar with icon
        title: Center(
          child: Text("KOS 33 - Daftar Penghuni Kos"),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              icon: Icon(Icons.search))
        ],
        backgroundColor: Colors.amber[900],
      ),
      body: StreamBuilder<QuerySnapshot>(
        //data to be retrieved in the future
        stream: users.where('tglKeluar', isEqualTo: "").snapshots(),
        builder: (_, snapshot) {
          //show if there is data
          if (snapshot.hasData) {
            // we take the document and pass it to a variable
            var alldata = snapshot.data!.docs;

            //if there is data, make list
            return alldata.length != 0
                ? ListView.builder(

                    // displayed as much as the variable data alldata
                    itemCount: alldata.length,

                    //make custom item with list tile.
                    itemBuilder: (_, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.amber[900],
                          foregroundColor: Colors.white,
                          //get first character of name
                          child: Text(alldata[index]['nama'][0]),
                        ),
                        title: Text(alldata[index]['nama'],
                            style: TextStyle(fontSize: 20)),
                        subtitle: Text(alldata[index]['noHp'],
                            style: TextStyle(fontSize: 16)),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                //pass data to edit form
                                MaterialPageRoute(
                                    builder: (context) => FormPage(
                                          id: snapshot.data!.docs[index].id,
                                        )),
                              );
                            },
                            icon: Icon(Icons.arrow_forward_rounded)),
                      );
                    })
                : Center(
                    child: Text(
                      'No Data',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
          } else {
            return Center(child: Text("Loading...."));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormPage()),
          );
        },
        backgroundColor: Colors.amber[900],
        child: Icon(Icons.add),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = ['Apple', 'Banana', 'Pear', 'Watermelon'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
