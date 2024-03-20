import 'package:find_missing_people/utils/colors.dart';
import 'package:flutter/material.dart';

class notifyPolice extends StatefulWidget {
  const notifyPolice({super.key});

  @override
  State<notifyPolice> createState() => _notifyPoliceState();
}

class _notifyPoliceState extends State<notifyPolice> {
//   void sendSms(String msg, List<String> list_receipents) async {
//  String send_result = await sendSms(message: msg, recipients: list_receipents)
//         .catchError((err) {
//       print(err);
//     });
// print(send_result);
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notify Police",
          style: TextStyle(fontSize: 30, fontFamily: 'montserrat'),
        ),
      ),
      body: Center(
        child: GestureDetector(
          // onTap: sendSms("Hello", ['9746157130']),
          child: Container(
            color: theYellowColor,
            height: 90,
            width: 200,
          ),
        ),
      ),
    );
  }
}
