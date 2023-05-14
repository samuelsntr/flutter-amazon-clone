import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<List<File>> pickImage() async {
  List<File> images = [];
  try {
    var img = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (img != null && img.files.isNotEmpty) {
      for (int i = 0; i < img.files.length; i++) {
        images.add(
          File(img.files[i].path!),
        );
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
