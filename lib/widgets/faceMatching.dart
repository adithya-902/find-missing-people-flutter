import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:find_missing_people/widgets/loading.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:image/image.dart' as img;

class CapturedImageScreen extends StatelessWidget {
  final String imagePath;

  

  const CapturedImageScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Store the context in a variable before entering the asynchronous context
    final currentContext = context;

    Future<List<String>> getImageUrls() async {
      try {
        QuerySnapshot querySnapshot =
            await FirebaseFirestore.instance.collection('missing').get();

        List<String> imageUrls = [];
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          String imageUrl = documentSnapshot.get('image');
          print(imageUrl);
          imageUrls.add(imageUrl);
        }

        return imageUrls;
      } catch (e) {
        // Handle any potential errors
        print('Error retrieving image URLs: $e');
        return [];
      }
    }

    Future<List<Uint8List>> getImageBytes(List<String> imageUrls) async {
      List<Uint8List> imageBytesList = [];

      for (String imageUrl in imageUrls) {
        final response = await http.get(Uri.parse(imageUrl));

        if (response.statusCode == 200) {
          // Convert the image data to bytes
          Uint8List imageBytes = response.bodyBytes;
          imageBytesList.add(imageBytes);
        } else {
          // Handle error if the image couldn't be downloaded
          print('Error downloading image: ${response.statusCode}');
        }
      }

      return imageBytesList;
    }

    double _euclideanDistance(List<double> a, List<double> b) {
      double sum = 0.0;
      for (int i = 0; i < a.length; i++) {
        double diff = a[i] - b[i];
        sum += diff * diff;
      }
      return sqrt(sum);
    }

    Future<bool> checkMatch(String imagePath) async {
      // final faceDetector = GoogleMlKit.vision.faceDetector();
      // const modelPath = 'mobilefacenet.tflite';
      // Uint8List imageByte;
      // final model =
      //     await Interpreter.fromAsset(modelPath, options: InterpreterOptions());
      // List<String> imageUrls = await getImageUrls();
      // List<Uint8List> imageBytes = await getImageBytes(imageUrls);
      // for (imageByte in imageBytes) {
      //   var inputImage1;
      //   final input1 = _prepareInputTensor(inputImage1, inputShape);
      //   final input2 = _prepareInputTensor(inputImage2, inputShape);

      //   var outputShape;
      //   final output1 =
      //       List.filled(outputShape[1], 0.0).reshape([1, outputShape[1]]);
      //   final output2 =
      //       List.filled(outputShape[1], 0.0).reshape([1, outputShape[1]]);
      //   print("outputShape $outputShape");
      //   print("output1 $output1");
      //   print("output2 $output2");
      //   model.run(input1, output1);
      //   model.run(input2, output2);

      //   final distance = _euclideanDistance(output1[0], output2[0]);

      //   //final face = faceDetector.processImage(imageByte);
      // }
      return true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Captured Image'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.file(File(imagePath)),
          ),
          ElevatedButton(
            onPressed: () {
              // Use the stored context to navigate back to the camera screen
              Navigator.pop(currentContext);
            },
            child: const Text('Retake'),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => loading()));
              },
              child: const Text(
                "Check match",
                style: TextStyle(fontFamily: "montserrat"),
              ))
        ],
      ),
    );
  }
}

class _prepareInputTensor {
  _prepareInputTensor(inputImage1, inputShape);
}
