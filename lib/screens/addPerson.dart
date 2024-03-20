import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_missing_people/utils/addMissing.dart';
import 'package:find_missing_people/utils/colors.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:find_missing_people/utils/pickImage.dart';
import 'package:find_missing_people/widgets/loading.dart';
import 'package:find_missing_people/widgets/text_input_field.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class addPerson extends StatefulWidget {
  addPerson({super.key});

  @override
  State<addPerson> createState() => _addPersonState();
}

class _addPersonState extends State<addPerson> {
  double _uploadProgress = 0.0;
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _fathercontroller = TextEditingController();
  final TextEditingController _heightcontroller = TextEditingController();
  final TextEditingController _agecontroller = TextEditingController();
  final TextEditingController _locationcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  Uint8List? _image;

  void addImage() async {
    Uint8List img = await pickImage(ImageSource.camera);
    setState(() {
      _image = img;
    });
  }

  void addUser() async {
    String resp = "Some error ocuured";

    try {
      if (_namecontroller.text != "" ||
          _fathercontroller.text != "" ||
          _heightcontroller.text != "" ||
          _agecontroller.text != "" ||
          _phonecontroller.text != "" ||
          _locationcontroller.text != "") {
        String imgUrl =
            await StoreData().uploadImage(_namecontroller.text, _image!);
        
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => loading()));
        await FirebaseFirestore.instance.collection("missing").add({
          "name": _namecontroller.text,
          "father_name": _fathercontroller.text,
          "height": _heightcontroller.text,
          "age": _agecontroller.text,
          "phone": _phonecontroller.text,
          "address": _locationcontroller.text,
          "image": imgUrl
        });
        
        // Navigator.pop(context);
        resp = 'Success';
      } else {
        resp = "Enter all fields";
      }
    } catch (err) {
      resp = err.toString();
    }

    if (resp == 'Success') {
      _namecontroller.clear();
      _fathercontroller.clear();
      _heightcontroller.clear();
      _agecontroller.clear();
      _phonecontroller.clear();
      _locationcontroller.clear();
      setState(() {
        _image = null;
      });
    }
    // ignore: use_build_context_synchronously
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                resp,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "montserrat",
                    fontSize: 30),
              ),
            ),
            backgroundColor: theYellowColor,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Person')),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            // const SizedBox(
            //   height: 10,
            // ),
            _image != null
                ? GestureDetector(
                    onTap: addImage,
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage: MemoryImage(_image!),
                    ),
                  )
                : IconButton(
                    onPressed: addImage,
                    icon: const Icon(Icons.add_a_photo_outlined),
                    iconSize: 150,
                  ),
            const SizedBox(
              height: 20,
            ),

            TextFieldInput(
                textEditingController: _namecontroller,
                hintText: "Name",
                textInputType: TextInputType.name),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
                textEditingController: _fathercontroller,
                hintText: "Father's Name",
                textInputType: TextInputType.name),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
                textEditingController: _heightcontroller,
                hintText: "Height",
                textInputType: TextInputType.name),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
                textEditingController: _agecontroller,
                hintText: "Age",
                textInputType: TextInputType.name),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
                textEditingController: _locationcontroller,
                hintText: "Address",
                textInputType: TextInputType.name),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
                textEditingController: _phonecontroller,
                hintText: "Phone number",
                textInputType: TextInputType.name),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: GestureDetector(
                onTap: addUser,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: theYellowColor,
                  ),
                  child: const Center(
                      child: Text(
                    "Submit",
                    style: TextStyle(
                      fontFamily: 'montserrat',
                      fontSize: 30,
                    ),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
