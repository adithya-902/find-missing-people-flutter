import 'package:find_missing_people/screens/addPerson.dart';
import 'package:find_missing_people/screens/checkFace.dart';
import 'package:find_missing_people/screens/missingList.dart';
import 'package:find_missing_people/screens/notifyPolice.dart';
import 'package:find_missing_people/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signUserOut() async {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.signOut();
    // await user?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("LAAPATA",
              style: TextStyle(
                  fontFamily: 'montserrat',
                  fontSize: 40,
                  fontWeight: FontWeight.w500)),
        ),
        actions: [
          IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Container(
                      height: 150,
                      width: 175,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: theYellowColor),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => notifyPolice()));
                        },
                        child: const Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Icon(
                                Icons.local_police_sharp,
                                size: 80,
                              ),
                              Text(
                                "Notify Police",
                                style: TextStyle(
                                    fontFamily: "montserrat",
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 150,
                          width: 175,
                          margin: EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: theYellowColor),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => checkFace()));
                            },
                            child: const Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Icon(
                                    Icons.camera_enhance_rounded,
                                    size: 80,
                                  ),
                                  Text(
                                    "Check Face",
                                    style: TextStyle(
                                        fontFamily: "montserrat",
                                        fontWeight: FontWeight.w900),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 150,
                    width: 175,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: theYellowColor),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => addPerson()));
                      },
                      child: const Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Icon(
                              Icons.person_add_alt_1,
                              size: 80,
                            ),
                            Text(
                              "Add missing person",
                              style: TextStyle(
                                  fontFamily: "montserrat",
                                  fontWeight: FontWeight.w900),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 175,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: theYellowColor),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => missingList()));
                      },
                      child: const Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Icon(
                              Icons.list_alt_outlined,
                              size: 80,
                            ),
                            Text(
                              "Missing list",
                              style: TextStyle(
                                  fontFamily: "montserrat",
                                  fontWeight: FontWeight.w900),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
