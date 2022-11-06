import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proje_1/urun.dart';

// ignore: camel_case_types
class onecikanurunler extends StatefulWidget {
  const onecikanurunler({Key? key}) : super(key: key);

  @override
  State<onecikanurunler> createState() => _onecikanurunlerState();
}

// ignore: camel_case_types
class _onecikanurunlerState extends State<onecikanurunler> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 60,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 255,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: 260),
          itemBuilder: (context, index) {
            // CrossAxisAlignment.center;
            return ClayContainer(
              borderRadius: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => urun(
                              isim: isimList[index].toString(),
                              fiyat: fiyatList[index],
                            )),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  //  decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                              margin: const EdgeInsets.only(top: 3),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              height: 200,
                              width: 177,
                              child: Image.asset(
                                "assets/images/yukleniyor.png",
                                fit: BoxFit.cover,
                              ) /*FadeInImage.assetNetwork(
                              placeholder: "assets/images/yukleniyor.png",
                              image: urun,//imgList[index].toString(),
                              fit: BoxFit.cover,
                            ),*/
                              ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: SizedBox(
                            child: Text(
                              //"URUN",
                              isimList[index].toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: SizedBox(
                            child: Text(
                                /*"Urun Fiyat", */ fiyatList[index].toString() +
                                    " TL",
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

/*List imgList = [
  "https://www.modaymis.com/i/l/052/0521647_aksesuar-gozluk-siyah-92241356.jpeg",
  "https://www.modaymis.com/i/l/048/0487865_10-cm-cam-topuklu-ayakkabi-krem-6393264.jpeg",
  "https://www.modaymis.com/i/l/049/0497503_tek-omuz-askili-bustiyer-sari-86931092.jpeg",
  "https://www.modaymis.com/i/l/050/0503785_citcitli-gabardin-ceket-mint-89511367.jpeg",
  "https://www.modaymis.com/i/l/052/0524722_kollari-tullu-sandy-elbise-siyah-100281594.jpeg",
  "https://www.modaymis.com/i/l/049/0491590_salas-kot-pantolon-siyah-8612925.jpeg",
  "https://www.modaymis.com/i/l/049/0498960_prenses-kol-bluz-beyaz-11021320.jpeg",
  "https://www.modaymis.com/i/l/052/0520510_ip-askili-elbise-siyah-92671062.jpeg",
  "https://www.modaymis.com/i/l/052/0529807_babet-ayakkabi-ten-9441264.jpeg",
  "https://www.modaymis.com/i/l/050/0506413_dar-paca-kot-pantolon-koyumavi-90431361.jpeg",
  "https://www.modaymis.com/i/l/051/0516541_fitilli-garnili-takim-siyah-92351567.jpeg",
  "https://www.modaymis.com/i/l/051/0519116_ispanyol-paca-yirtmacli-kot-pantolon-koyufume-88391184.jpeg",
  "https://www.modaymis.com/i/l/050/0502079_kayis-kordon-saat-gold-6348841.jpeg",
  "https://www.modaymis.com/i/l/051/0516263_parasut-dakron-sweat-bej-3193105.jpeg",
  "https://www.modaymis.com/i/l/051/0513778_baskili-yirtmacli-tisort-beyaz-3383105.jpeg",
  "https://www.modaymis.com/i/l/052/0523930_palazzo-pantolon-tarcin-1271322.jpeg",
  "https://www.modaymis.com/i/l/051/0513762_yaka-buzgulu-elbise-pembe-26871595.jpeg",
  "https://www.modaymis.com/i/l/051/0513762_yaka-buzgulu-elbise-pembe-26871595.jpeg",
  "https://www.modaymis.com/i/l/052/0523291_omuz-askili-bluz-fusya-9428148.jpeg",
  "https://www.modaymis.com/i/l/052/0524623_digital-baskili-kolu-tullu-bluz-kahvecicekli-2641247.jpeg",
  "https://www.modaymis.com/i/l/051/0514388_cizgili-duble-kol-tisort-siyahpudra-3423105.jpeg",
  "https://www.modaymis.com/i/l/050/0502051_metal-kordon-saat-gold-1253841.jpeg",
  "https://www.modaymis.com/i/l/050/0507124_kollari-beli-motifli-abiye-kirmizi-38659100.jpeg",
  "https://ktnimg.mncdn.com/product-images/2SAL40145IW999/1500Wx1969H/2SAL40145IW999_G01_zoom1_V01.jpg",
  "https://www.modaymis.com/i/l/050/0509636_buyuk-beden-tisort-ekru-89991361.jpeg",
  "https://www.modaymis.com/i/l/048/0486229_desteksiz-bralet-takim-mor-20841364.jpeg",
  "https://www.modaymis.com/i/l/048/0486496_dantel-fantazi-sutyen-takim-mor-30101364.jpeg",
  "https://www.modaymis.com/i/l/048/0486496_dantel-fantazi-sutyen-takim-mor-30101364.jpeg",
  "https://www.modaymis.com/i/l/048/0484439_tul-kollu-bluz-pembe1-8713107.jpeg",
  "https://www.modaymis.com/i/l/051/0514966_destekli-bralet-takim-zebra-20751364.jpeg",
  "https://www.modaymis.com/i/l/050/0501413_halter-atlet-gri-88621092.jpeg",
  "https://www.modaymis.com/i/l/048/0486503_fantazi-babydoll-gecelik-kirmizi-30151364.jpeg",
  "https://www.modaymis.com/i/l/050/0501380_prenses-kol-bluz-bordo-52701234.jpeg",
  "https://www.modaymis.com/i/l/049/0490427_gunluk-ayakkabi-siyah-5644264.jpeg",
  "https://www.modaymis.com/i/l/050/0500042_7-cm-topuklu-ayakkabi-siyahderi-8921264.jpeg",
  "https://www.modaymis.com/i/l/051/0516290_askili-elbise-siyah-5817461592.jpeg",
  "https://www.modaymis.com/i/l/052/0527252_unisex-arka-baskili-tisort-beyaz-93611377.jpeg",
  "https://www.modaymis.com/i/l/051/0511120_ip-askili-sortlu-takim-lacivert-6186729.jpeg",
  "https://www.modaymis.com/i/l/052/0522682_kot-sort-pembe-93061590.jpeg",
  "https://www.modaymis.com/i/l/050/0505896_ip-askili-atlet-acikkahve-90171153.jpeg",
  "https://www.modaymis.com/i/l/052/0525491_alti-puskullu-elbise-fume1-55051287.jpeg",
  "https://ktnimg.mncdn.com/product-images/2SAK30035EW0D1/1500Wx1969H/2SAK30035EW0D1_G01_zoom1_V02.jpg",
  "https://ktnimg.mncdn.com/product-images/2SAK30053HT152/1500Wx1969H/2SAK30053HT152_G01_zoom1_V02.jpg",
  "https://www.modaymis.com/i/l/051/0517614_dugmeli-kot-etek-mavi-83531572.jpeg",
  "https://www.modaymis.com/i/l/048/0485882_fantazi-gecelik-mor-30371364.jpeg",
  "https://www.modaymis.com/i/l/049/0497813_onu-firfirli-elbise-pembedesenli-2404555.jpeg",
  "https://www.modaymis.com/i/l/048/0486463_dantel-fantazi-sutyen-takim-kirmizi-30101364.jpeg",
  "https://www.modaymis.com/i/l/052/0521674_aksesuar-gozluk-siyah-92211356.jpeg",
  "https://www.modaymis.com/i/l/050/0502012_metal-kordon-saat-bronz-3744841.jpeg",
  "https://www.modaymis.com/i/l/048/0488288_9-cm-topuklu-ayakkabi-siyahderi-8741264.jpeg",
  "https://www.modaymis.com/i/l/050/0504487_kruvaze-yaka-elbise-zebra-21100101.jpeg",
  "https://www.modaymis.com/i/l/052/0529482_babet-ayakkabi-siyah-9437264.jpeg",
  "https://www.modaymis.com/i/l/052/0521771_aksesuar-gozluk-kahve-92201356.jpeg",
  "https://www.modaymis.com/i/l/051/0514641_cepli-gomlek-pastelyesil-21301602.jpeg",
  "https://www.modaymis.com/i/l/050/0502023_dijital-saat-gold-1013841.jpeg",
  "https://www.modaymis.com/i/l/047/0471804_daniel-klein-gozluk-col2-4173443.jpeg",
  "https://www.modaymis.com/i/l/052/0529955_gipeli-tulum-gulkurusu-1127134.jpeg",
  "https://www.modaymis.com/i/l/052/0521490_aksesuar-gozluk-mavi-92101356.jpeg",
  "https://www.modaymis.com/i/l/052/0529742_babet-ayakkabi-platin-9437264.jpeg",
  "https://www.modaymis.com/i/l/050/0505009_parcali-kilos-etek-tas-8992148.jpeg",
];
*/
List isimList = [
  "Gözlük Siyah Aksesuar",
  "Krem Cam Topuklu Ayakkabı Cm",
  "Sarı Tek Bustiyer Askılı Omuz",
  "Gabardin Çıtçıtlı Mint Ceket",
  "Sandy Elbise Siyah Kolları Tüllü",
  "Salaş Kot Siyah Pantolon",
  "Prenses Kol Bluz Beyaz",
  "İp Askılı Elbise Siyah",
  "Ayakkabı Babet Ten",
  "Dar Pantolon Kot Paça Koyumavi",
  "Garnili Siyah Takım Fitilli",
  "Koyufüme Yırtmaçlı Kot İspanyol Pantolon Paça",
  "Gold Kayış Kordon Saat",
  "Sweat Bej Paraşüt Dakron",
  "Beyaz Baskılı Tişört Yırtmaçlı",
  "Palazzo Pantolon Tarçın",
  "Yaka Büzgülü Pembe Elbise",
  "Koton Erkek Çocuk Fermuar Detaylı Bel Çantası",
  "Askılı Bluz Fuşya Omuz",
  "Bluz Tüllü Baskılı Kahveçiçekli Digital Kolu",
  "Tişört Duble Kol Siyahpudra Çizgili",
  "Gold Kordon Saat Metal",
  "Abiye Kolları Kırmızı Motifli Beli",
  "Koton Ole Genç Kız Paçası Kısa Yırtmaçlı İspanyol Paça Yüksel Bel",
  "Ekru Tişört Beden Büyük",
  "Mor Bralet Desteksiz Takım",
  "Sütyen Dantel Fantazi Takım Mor",
  "Koton Kadın Yırtmaçlı Elbise Fitilli Büzgülü Pencere Detaylı",
  "Pembe Bluz Tül Kollu",
  "Bralet Destekli Takım Zebra",
  "Halter Atlet Gri",
  "Gecelik Fantazi Babydoll Kırmızı",
  "Kol Prenses Bluz Bordo",
  "Günlük Siyah Ayakkabı",
  "Ayakkabı 18 Cm Siyahderi Topuklu",
  "Siyah Askılı Elbise",
  "Baskılı Unisex Beyaz Tişört Arka",
  "Lacivert Şortlu Takım Askılı İp",
  "Şort Pembe Kot",
  "Açıkkahve İp Atlet Askılı",
  "Füme Elbise Püsküllü Altı",
  "Koton Kadın Boyundan Bağlamalı Büstiyer Desenli Pencere Detaylı",
  "Koton Kadın Boyundan Bağlamalı Büstiyer Desenli Pencere Detaylı",
  "Etek Düğmeli Mavi Kot",
  "Gecelik Mor Fantazi",
  "Pembedesenli Elbise Fırfırlı Önü",
  "Takım Fantazi Kırmızı Sütyen Dantel",
  "Aksesuar Gözlük Siyah",
  "Bronz Metal Saat Kordon",
  "Siyahderi Topuklu 9 Cm Ayakkabı",
  "Zebra Yaka Kruvaze Elbise",
  "Babet Ayakkabı Siyah",
  "Aksesuar Gözlük Kahve",
  "Pastelyeşil Gömlek Cepli",
  "Saat Gold Dijital",
  "Kleın Col Danıel Gözlük",
  "Tulum Gipeli Gülkurusu",
  "Gözlük Mavi Aksesuar",
  "Platin Ayakkabı Babet",
  "Etek Kiloş Taş Parçalı",
];

List fiyatList = [
  71.00,
  214.00,
  29.00,
  132.00,
  161.00,
  154.00,
  54.00,
  48.00,
  188.00,
  118.00,
  79.00,
  185.00,
  101.00,
  97.00,
  67.00,
  178.00,
  132.00,
  99.99,
  75.00,
  66.00,
  64.00,
  140.00,
  492.00,
  279.99,
  59.00,
  79.00,
  41.00,
  179.99,
  41.00,
  79.00,
  31.00,
  64.00,
  79.00,
  90.00,
  188.00,
  114.00,
  90.00,
  55.00,
  85.00,
  41.00,
  50.00,
  119.99,
  179.99,
  93.00,
  62.00,
  85.00,
  41.00,
  71.00,
  120.00,
  201.00,
  107.00,
  142.00,
  51.00,
  132.00,
  140.00,
  149.00,
  185.00,
  177.00,
  142.00,
  59.00,
];
