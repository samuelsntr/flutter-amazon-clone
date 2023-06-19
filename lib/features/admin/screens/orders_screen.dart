import 'package:amazone_clone/common/widget/loader.dart';
import 'package:amazone_clone/features/account/widgets/single_product.dart';
import 'package:amazone_clone/features/admin/services/admin_services.dart';
import 'package:amazone_clone/features/order_detail/screens/order_detail_screen.dart';
import 'package:amazone_clone/models/order.dart';
import 'package:flutter/material.dart';

class OrderScreenAdmin extends StatefulWidget {
  const OrderScreenAdmin({super.key});

  @override
  State<OrderScreenAdmin> createState() => _OrderScreenAdminState();
}

class _OrderScreenAdminState extends State<OrderScreenAdmin> {
  final AdminServices adminServices = AdminServices();
  List<Order>? orderList;
  @override
  void initState() {
    super.initState();
    fetchAllOrders();
  }

  void fetchAllOrders() async {
    orderList = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orderList == null
        ? const Center(child: Loader())
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: orderList!.length,
            itemBuilder: (context, index) {
              final orderData = orderList![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailScreen.routeName,
                      arguments: orderData);
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(
                    image: orderData.products[0].images[0],
                  ),
                ),
              );
            },
          );
  }
}
