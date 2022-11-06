import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SliderMenu extends StatefulWidget {
  const SliderMenu({Key? key}) : super(key: key);

  @override
  State<SliderMenu> createState() => _SliderMenuState();
}

class _SliderMenuState extends State<SliderMenu> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1,
        height: 240,
        autoPlay: true,
      ),
      items: imgList.map((imgAsset) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
              decoration: const BoxDecoration(color: Colors.white),
              child: Image.asset(
                imgAsset,
                fit: BoxFit.fill,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

List imgList = [
  "assets/images/ayakkabı.png",
  "assets/images/canta.png",
  "assets/images/elbise.png",
  "assets/images/gozluk.png",
  "assets/images/kot.png",
  "assets/images/pijama.png",
  "assets/images/sort.png",
  "assets/images/tisort.png",
  "assets/images/topuklu.png",
];
List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}
