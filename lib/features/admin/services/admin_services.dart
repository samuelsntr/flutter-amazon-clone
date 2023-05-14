import 'dart:io';

import 'package:amazone_clone/constants/utils.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required List<File> images,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('duvmt2rby', 'qzknxucq');
      List<String> imageUrl = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrl.add(res.secureUrl);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
