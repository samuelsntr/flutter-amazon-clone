import 'package:amazone_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages
          .map(
            (img) => Builder(
              builder: (BuildContext context) => Image.network(
                img,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}
