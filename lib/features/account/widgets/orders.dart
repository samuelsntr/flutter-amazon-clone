import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List example = [
    'https://media.istockphoto.com/id/1385042040/id/foto/tangan-pembantu-mencuci-tomat-sayuran-segar-persiapan-makanan-sehat-di-dapur.jpg?s=612x612&w=0&k=20&c=v428jkaRxlk7bzrmMBaqbQuVOkQLFJxeeRx5XPVOAvM=',
    'https://media.istockphoto.com/id/1385042040/id/foto/tangan-pembantu-mencuci-tomat-sayuran-segar-persiapan-makanan-sehat-di-dapur.jpg?s=612x612&w=0&k=20&c=v428jkaRxlk7bzrmMBaqbQuVOkQLFJxeeRx5XPVOAvM=',
    'https://media.istockphoto.com/id/1385042040/id/foto/tangan-pembantu-mencuci-tomat-sayuran-segar-persiapan-makanan-sehat-di-dapur.jpg?s=612x612&w=0&k=20&c=v428jkaRxlk7bzrmMBaqbQuVOkQLFJxeeRx5XPVOAvM=',
    'https://media.istockphoto.com/id/1385042040/id/foto/tangan-pembantu-mencuci-tomat-sayuran-segar-persiapan-makanan-sehat-di-dapur.jpg?s=612x612&w=0&k=20&c=v428jkaRxlk7bzrmMBaqbQuVOkQLFJxeeRx5XPVOAvM=',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                'Your Orders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                'See all',
                style: TextStyle(color: GlobalVariables.selectedNavBarColor),
              ),
            ),
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: example.length,
            itemBuilder: (context, index) {
              return SingleProduct(
                image: example[index],
              );
            },
          ),
        )
      ],
    );
  }
}
