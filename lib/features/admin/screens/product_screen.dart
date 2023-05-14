import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/admin/screens/add_product.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  void navigateAddProduct() {
    Navigator.pushNamed(context, AddProduct.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Product'),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: GlobalVariables.appBarGradient,
        ),
        child: FloatingActionButton(
          elevation: 0,
          onPressed: navigateAddProduct,
          backgroundColor:
              Colors.transparent, // Atur latar belakang FAB menjadi transparan
          tooltip: 'Add a Product',
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
