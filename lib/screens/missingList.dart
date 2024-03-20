import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_missing_people/utils/colors.dart';
import 'package:flutter/material.dart';

class missingList extends StatefulWidget {
  const missingList({super.key});

  @override
  State<missingList> createState() => _missingListState();
}

class _missingListState extends State<missingList> {
  Future<List<Map<String, dynamic>>> getDataFromFirestore() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    return querySnapshot.docs.map((DocumentSnapshot doc) {
      return {
        'name': doc['name'],
        'phoneNumber': doc['phoneNumber'],
        'address': doc['address'],
        'imageUrl': doc['imageUrl'],
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Missing People",
            style: TextStyle(
                fontFamily: "montserrat", fontWeight: FontWeight.w500),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("missing").snapshots(),
          builder: (context, snapshot) {
            List<Row> clientWidgets = [];
            if (snapshot.hasData) {
              final clients = snapshot.data?.docs.reversed.toList();
              for (var client in clients!) {
                final clientWidget = Row(
                  children: [
                    Center(
                      child: Container(
                        width: 382,
                        height: 150,
                        child: Card(
                          color: theYellowColor,
                          margin: EdgeInsets.all(12),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      NetworkImage(client["image"]),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 30),
                                  width: 212,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Text(client["address"],
                                            style: const TextStyle(
                                                fontFamily: 'montserrat',
                                                fontSize: 8,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black87)),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            client['name'],
                                            style: const TextStyle(
                                                fontFamily: 'montserrat',
                                                fontSize: 30,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black87),
                                          ),
                                          Text(client['phone'],
                                              style: const TextStyle(
                                                  fontFamily: 'montserrat',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black87)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
                clientWidgets.add(clientWidget);
              }
            }

            return Center(
              child: Row(
                children: [
                  Expanded(
                    child: ListView(
                      children: clientWidgets,
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
