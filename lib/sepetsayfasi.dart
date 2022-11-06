import 'dart:async';

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SepetSayfasi extends StatefulWidget {
  const SepetSayfasi({Key? key}) : super(key: key);

  @override
  State<SepetSayfasi> createState() => _SepetSayfasiState();
}

class _SepetSayfasiState extends State<SepetSayfasi> {
  @override
  void initState() {
    asdf();
    urunGetir();
    super.initState();
  }

  Future<void> asdf() async {
    await execute(InternetConnectionChecker());
  }

  Future<void> execute(
    InternetConnectionChecker internetConnectionChecker,
  ) async {
    // ignore: unused_local_variable
    final StreamSubscription<InternetConnectionStatus> listener =
        InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            break;
          case InternetConnectionStatus.disconnected:
            Navigator.pushNamedAndRemoveUntil(
                context, '/baglantiyok', (route) => false);
            break;
        }
      },
    );

    /*await Future<void>.delayed(const Duration(seconds: 30));
    await listener.cancel();
    */
  }

  Map _bilgi = {"Adı": "", "Adet": "", "Fiyat": 0, "Beden": ""};
  List<Map> tumurunler = [];
  int _toplamurun = 0;
  bool _sepetbos = true;
  String? _secilenSehir;
  final List<String> _tumSehirler = [
    "Adana",
    "Adıyaman",
    "Afyonkarahisar",
    "Ağrı",
    "Aksaray",
    "Amasya",
    "Ankara",
    "Antalya",
    "Ardahan",
    "Artvin",
    "Aydın",
    "Balıkesir",
    "Bartın",
    "Batman",
    "Bayburt",
    "Bilecik",
    "Bingöl",
    "Bitlis",
    "Bolu",
    "Burdur",
    "Bursa",
    "Çanakkale",
    "Çankırı",
    "Çorum",
    "Denizli",
    "Diyarbakır",
    "Düzce",
    "Edirne",
    "Elazığ",
    "Erzincan",
    "Erzurum",
    "Eskişehir",
    "Gaziantep",
    "Giresun",
    "Gümüşhane",
    "Hakkâri",
    "Hatay",
    "Iğdır",
    "Isparta",
    "İstanbul",
    "İzmir",
    "Kahramanmaraş",
    "Karabük",
    "Karaman",
    "Kars",
    "Kastamonu",
    "Kayseri",
    "Kilis",
    "Kırıkkale",
    "Kırklareli",
    "Kırşehir",
    "Kocaeli",
    "Konya",
    "Kütahya",
    "Malatya",
    "Manisa",
    "Mardin",
    "Mersin",
    "Muğla",
    "Muş",
    "Nevşehir",
    "Niğde",
    "Ordu",
    "Osmaniye",
    "Rize",
    "Sakarya",
    "Samsun",
    "Şanlıurfa",
    "Siirt",
    "Sinop",
    "Sivas",
    "Şırnak",
    "Tekirdağ",
    "Tokat",
    "Trabzon",
    "Tunceli",
    "Uşak",
    "Van",
    "Yalova",
    "Yozgat",
    "Zonguldak"
  ];
  @override
  Widget build(BuildContext context) {
    if (_toplamurun == 0) {
      _sepetbos = true;
    } else {
      _sepetbos = false;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Image.asset(
            "assets/images/yazilogo.jpg",
            fit: BoxFit.cover,
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: _sepetbos,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 225,
                            child: Center(
                                child: Text(
                              "Sepetiniz Boş",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.center,
                            )),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/anasayfa',
                                  arguments: {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Alışverişe Başla",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 35),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Sipariş Özeti",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            height: 2,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(
                                "Toplam:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Text(
                                "0.00 TL",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !_sepetbos,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Sepetinizde $_toplamurun ürün bulunuyor.",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                              "Ürünleri sizin için 30 dakika rezerve ettik."),
                          const SizedBox(
                            height: 5,
                          ),
                          _urunListesi(),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Hemen Satın Al",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: Container(
                              height: 1,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 35),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              cursorColor: Colors.black,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                labelText: "Adınız",
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.amber)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                border: OutlineInputBorder(),
                                hintText: "Adınız",
                              ),
                              validator: (deger) {
                                if (deger!.isEmpty) {
                                  return "Ad Kısmı Boş Bırakılamaz!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 35),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              cursorColor: Colors.black,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                labelText: "Soyadınız",
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.amber)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                border: OutlineInputBorder(),
                                hintText: "Soyadınız",
                              ),
                              validator: (deger) {
                                if (deger!.isEmpty) {
                                  return "Soyad Kısmı Boş Bırakılamaz!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 35),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              cursorColor: Colors.black,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                labelText: "Cep Telefonu",
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.amber)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                border: OutlineInputBorder(),
                                hintText: "0(555) 555 55 55",
                              ),
                              validator: (deger) {
                                if (deger!.isEmpty) {
                                  return "Telefon Kısmı Boş Bırakılamaz!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 35),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              cursorColor: Colors.black,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                labelText: "Adres",
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.amber)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                border: OutlineInputBorder(),
                                hintText: "Adres",
                              ),
                              validator: (deger) {
                                if (deger!.isEmpty) {
                                  return "Adres Kısmı Boş Bırakılamaz!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 35),
                            //padding: EdgeInsets.symmetric(horizontal: 0),
                            child: Center(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: DropdownButton<String>(
                                    isExpanded: true,
                                    iconSize: 25,
                                    underline: Container(
                                      height: 0,
                                    ),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                    hint: const Text(
                                      "İl",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    items: _tumSehirler
                                        .map(
                                          (String oAnkiSehir) =>
                                              DropdownMenuItem(
                                            child: Text(oAnkiSehir),
                                            value: oAnkiSehir,
                                          ),
                                        )
                                        .toList(),
                                    value: _secilenSehir,
                                    onChanged: (String? yeni) {
                                      if (yeni!.isEmpty) {
                                      } else {}
                                      setState(() {
                                        _secilenSehir = yeni;
                                      });
                                    }),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 35),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              cursorColor: Colors.black,
                              maxLines: 1,
                              // ignore: prefer_const_constructors
                              decoration: InputDecoration(
                                labelText: "İlçe",
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.amber)),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                border: const OutlineInputBorder(),
                                hintText: "İlçe",
                              ),
                              validator: (deger) {
                                if (deger!.isEmpty) {
                                  return "İlçe Kısmı Boş Bırakılamaz!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 35),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Sipariş Özeti",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  height: 2,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      "Toplam:",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    Text(
                                      toplamtutar.toString() + " TL",
                                      style: const TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            onPressed: () {},
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 25, 135, 84),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text(
                                "Üyeliksiz Satın Al",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/giris");
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text(
                                "Giriş Yap veya Kayıt Ol",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView _urunListesi() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        // CrossAxisAlignment.center;
        return _urunOlustur();
      },
      separatorBuilder: (context, index) {
        if (index != _toplamurun) {
          return const SizedBox(
              //height: 5,
              );
        } else {
          return const SizedBox(
            height: 0,
          );
        }
      },
    );
  }

  _urunOlustur() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _toplamurun,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 100,
        ),
        itemBuilder: (context, index) {
          if (tumurunler.isNotEmpty) {
            _bilgi = tumurunler[index];
          }
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: ClayContainer(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClayContainer(
                    borderRadius: 5,
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 5, top: 5),
                              child: Image.asset(
                                "assets/images/urun.jpeg",
                                fit: BoxFit.contain,
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                (tumurunler.isNotEmpty)
                                    ? _bilgi["Adı"].toString()
                                    : "",
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    (tumurunler.isNotEmpty)
                                        ? _bilgi["Adet"].toString()
                                        : "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const Text(
                                    " Adet ",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    (tumurunler.isNotEmpty)
                                        ? _bilgi["Beden"].toString()
                                        : "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const Text(
                                    " Beden",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Visibility(
                                          visible: _bilgi["Adet"] != 1,
                                          child: const Text("Birim Fiyatı: ")),
                                      Text(
                                          (tumurunler.isNotEmpty)
                                              ? _bilgi["Fiyat"].toString() +
                                                  " TL"
                                              : "",
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.orangeAccent,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Visibility(
                                    visible: _bilgi["Adet"] != 1,
                                    child: Row(
                                      children: [
                                        const Text("Toplam Fiyat: "),
                                        Text(
                                            (tumurunler.isNotEmpty)
                                                ? (_bilgi["Fiyat"] *
                                                            _bilgi["Adet"])
                                                        .toString() +
                                                    " TL"
                                                : "",
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.orangeAccent,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              var asd = tumurunler[index];
                              _silmePopUp(
                                asd["Adı"],
                                asd["Beden"],
                              );
                            },
                            child: const Icon(Icons.close),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  urunGetir() async {
    var boxs = Hive.box("SepettekiUrunler");
    // ignore: unused_local_variable
    for (var message in boxs.values) {
      tumurunler.add(message);
    }
    _toplamurun = tumurunler.length;
    hesapla();
  }

  double toplamtutar = 0;
  hesapla() {
    if (tumurunler.isNotEmpty) {
      for (var message in tumurunler) {
        toplamtutar += message["Fiyat"] * message["Adet"];
      }
    }
  }

  Future<void> _silmePopUp(String isim, String beden) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ürünü Sepetten Kaldır'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    '$isim İsimli Ürünü Sepetinizden Kaldırmak İstediğinize Emin Misiniz?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'İptal',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Evet',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                String urunad = isim + " " + beden + " " + "Beden";
                urunSil(urunad);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void urunSil(String _isim) async {
    var box = Hive.box("SepettekiUrunler");
    box.delete(_isim);
    Navigator.of(context).pop();
  }
}
