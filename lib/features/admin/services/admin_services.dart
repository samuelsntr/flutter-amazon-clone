import 'dart:convert';
import 'dart:io';

import 'package:amazone_clone/constants/error_handling.dart';
import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/models/product.dart';
import 'package:amazone_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  // ADD PROCUCT
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      final cloudinary = CloudinaryPublic('duvmt2rby', 'qzknxucq');
      List<String> imageUrl = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrl.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        images: imageUrl,
        category: category,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product Added Successfully');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // GET ALL PRODUCT
  Future<List<Product>> fetchAllProduct(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-products'), headers: {
        'Content-type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  // DELETE PRODUCT
  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res =
          await http.post(Uri.parse('$uri/admin/delete-products'),
              headers: {
                'Content-type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({'id': product.id}));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
