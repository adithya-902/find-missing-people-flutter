import 'dart:typed_data';
import 'package:find_missing_people/utils/colors.dart';
import 'package:flutter/material.dart';

class ImageListWidget extends StatelessWidget {
  final List<Uint8List> imageBytesList;

  ImageListWidget({required this.imageBytesList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imageBytesList.length,
      itemBuilder: (context, index) {
        return ImageCard(imageBytes: imageBytesList[index]);
      },
    );
  }
}

class ImageCard extends StatelessWidget {
  final Uint8List imageBytes;

  ImageCard({required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: theYellowColor,
      margin: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50, // Adjust the radius as needed
              child: Container(
                width: 100, // Adjust the width as needed
                height: 100, // Adjust the height as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: MemoryImage(imageBytes),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // You can add additional information or widgets here
          ],
        ),
      ),
    );
  }
}
