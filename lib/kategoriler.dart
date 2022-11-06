import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

class Kategoriler extends StatefulWidget {
  const Kategoriler({Key? key}) : super(key: key);

  @override
  State<Kategoriler> createState() => _KategorilerState();
}

class _KategorilerState extends State<Kategoriler> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 22,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 240,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 360),
          itemBuilder: (context, index) {
            return ClayContainer(
              borderRadius: 10,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                        height: 300,
                        width: 169,
                        child: Image.asset(
                          "assets/images/yukleniyor.png",
                        )
                        /*FadeInImage.assetNetwork(
                        placeholder: "assets/images/yukleniyor.png",
                        image: imgList[index].toString(),
                      ),*/
                        ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Container(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(isimList[index].toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

/*List imgList = [
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-abiye.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-atlet.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-babet-sandalet.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-bandana.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-basicler.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-bluz-body.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-bustiyer.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-esofman-alti.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-esofman-takimi.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-etek.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-fantezi.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-gomlek.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-hirka.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-ikili-takim.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-kemer.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-pantolon.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-sapka.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-sortlu-takim.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-tayt.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-terlik-panduf.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-tulum.jpg",
  "https://panel.enabase.com/images/kategori-gorsel/AVEB_1/carsi-nette-moda-tunik.jpg",
];
*/
/*List imgList = [
  "https://i.hizliresim.com/kf8icnd.jpg",
  "https://i.hizliresim.com/im2x42g.jpg",
  "https://i.hizliresim.com/o866ad9.jpg",
  "https://i.hizliresim.com/bzl82v2.jpg",
  "https://i.hizliresim.com/lpjikh2.jpg",
  "https://i.hizliresim.com/itgh4xq.jpg",
  "https://i.hizliresim.com/a21w2jn.jpg",
  "https://i.hizliresim.com/8wjlb76.jpg",
  "https://i.hizliresim.com/c3lw6s3.jpg",
  "https://i.hizliresim.com/tuulms9.jpg",
  "https://i.hizliresim.com/h79lkgc.jpg",
  "https://i.hizliresim.com/q8bbzdn.jpg",
  "https://i.hizliresim.com/5ou0sud.jpg",
  "https://i.hizliresim.com/kdpcfzb.jpg",
  "https://i.hizliresim.com/d6d6to2.jpg",
  "https://i.hizliresim.com/igy8j0i.jpg",
  "https://i.hizliresim.com/g50klgw.jpg",
  "https://i.hizliresim.com/5mr8mtw.jpg",
  "https://i.hizliresim.com/4q3nd1c.jpg",
  "https://i.hizliresim.com/qydq6kz.jpg",
  "https://i.hizliresim.com/jdfhwl0.jpg",
  "https://i.hizliresim.com/f4mwcsy.jpg",
];*/
List isimList = [
  "Abiye",
  "Atlet",
  "Babet - Sandalet",
  "Bandana",
  "Basicler",
  "Bluz - Body",
  "Büstiyer",
  "Eşofman Altı",
  "Eşofman Takımı",
  "Etek",
  "Fantezi",
  "Gömlek",
  "Hırka",
  "İkili Takım",
  "Kemer",
  "Pantolon",
  "Şapka",
  "Şortlu Takım",
  "Tayt",
  "Terlik - Panduf",
  "Tulum",
  "Tunik",
];
