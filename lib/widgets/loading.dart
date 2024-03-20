import 'package:find_missing_people/utils/colors.dart';
import 'package:flutter/material.dart';

class loading extends StatelessWidget {
  const loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 40,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: theYellowColor),
            child: const Center(
              child: Text(
                "Loading...",
                style: TextStyle(
                    fontFamily: "montserrat",
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
            ),
          )
        ],
      )),
    );
  }
}
