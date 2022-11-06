import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class blog extends StatefulWidget {
  const blog({Key? key}) : super(key: key);

  @override
  State<blog> createState() => _blogState();
}

// ignore: camel_case_types
class _blogState extends State<blog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 205),
          itemBuilder: (context, index) {
            return ClayContainer(
              borderRadius: 10,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Image.asset(
                          "assets/images/yukleniyor2.png",
                          fit: BoxFit.cover,
                        ) /*FadeInImage.assetNetwork(
                        placeholder: "assets/images/yukleniyor2.png",
                        image: imgList[index].toString(),
                        fit: BoxFit.cover,
                      ),*/
                        ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      child: Text(
                        "BLOG",
                        //aciklamaList[index].toString(),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );

    /*ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 3),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/yukleniyor.png",
                    image: imgList[index].toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  child: Text(
                    aciklamaList[index].toString(),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: 3);*/
  }
}

/*List imgList = [
  "https://www.carsinette.com/ezoimgfmt/kuponkod.s3-eu-west-1.amazonaws.com/coupon_tool_images/rsfeed-300x250-4.jpg?ezimgfmt=rs:414x345/rscb2/ng:webp/ngcb2",
  "https://www.carsinette.com/ezoimgfmt/kuponkod.s3-eu-west-1.amazonaws.com/coupon_tool_images/rsfeed-300x250-3.jpg?ezimgfmt=rs:414x345/rscb2/ng:webp/ngcb2",
  "https://www.carsinette.com/ezoimgfmt/kuponkod.s3-eu-west-1.amazonaws.com/coupon_tool_images/rsfeed-300x250-2.jpg?ezimgfmt=rs:414x345/rscb2/ng:webp/ngcb2",
];

List aciklamaList = [
  "Madame Coco 200 TL ve Üzeri Alışverişlerde 20 TL İndirim!",
  "Madame Coco Tüm Ürünlerde Sepette Yarısını Öde Fırsatı!",
  "Ayakkabı Dünyası Spor Ürünlerinde Sepette 500 TL ye 30 TL İndirim!",
];
*/