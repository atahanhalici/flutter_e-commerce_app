import 'dart:async';

import 'package:clay_containers/widgets/clay_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SepetAcikOturum extends StatefulWidget {
  const SepetAcikOturum({Key? key}) : super(key: key);

  @override
  State<SepetAcikOturum> createState() => _SepetAcikOturumState();
}

class _SepetAcikOturumState extends State<SepetAcikOturum> {
  late FirebaseAuth auth;
  @override
  void initState() {
    auth = FirebaseAuth.instance;
    asdf();
    adresGetir();
    adresSayisiGetir();
    urunGetir();
    urunSayisiGetir();
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
  Map _adresbilgi = {
    "Adı": "",
    "Soyadı": "",
    "Telefon": "",
    "İl": "",
    "İlçe": "",
    "Adres Adı": "",
    "Adres": ""
  };
  // ignore: prefer_final_fields
  Map<int, String> _secilenadresler = {};
  bool _ayniadres = true;
  List<Map> tumurunler = [];
  int _toplamurun = 0;
  int _secilenadres = 100;
  List<Map> adres = [];
  int _adressayisi = 0;
  // ignore: unused_field
  // ignore: unused_field
  @override
  Widget build(BuildContext context) {
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
              visible: _toplamurun == 0,
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
              visible: _toplamurun != 0,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 5,
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
                          SizedBox(
                              width: MediaQuery.of(context).size.width - 20,
                              child: _urunListesi()),
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
                            "Teslimat Adresi",
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
                          Visibility(
                            visible: _adressayisi != 0,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 40,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: _ayniadres == true
                                                  ? Colors.white
                                                  : const Color.fromARGB(
                                                      255, 226, 226, 226),
                                              border: Border(
                                                top: BorderSide(
                                                    width: 1.0,
                                                    color: _ayniadres == true
                                                        ? Colors.amber
                                                        : Colors.black),
                                              ),
                                            ),
                                            height: 30,
                                            child: const Center(
                                                child: Text(
                                              "Ürünleri Aynı Adrese Gönder",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 13),
                                            )),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _ayniadres = true;
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            height: 30,
                                            child: const Center(
                                                child: Text(
                                              "Her Ürün İçin Ayrı Adres Seç",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 13),
                                            )),
                                            decoration: BoxDecoration(
                                              color: _ayniadres == false
                                                  ? Colors.white
                                                  : const Color.fromARGB(
                                                      255, 226, 226, 226),
                                              border: Border(
                                                top: BorderSide(
                                                    width: 1.0,
                                                    color: _ayniadres == false
                                                        ? Colors.amber
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _ayniadres = false;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Visibility(
                                    visible: _ayniadres,
                                    child: GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: _adressayisi,
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent:
                                              _adressayisi % 2 == 0
                                                  ? 500
                                                  : 1000,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          mainAxisExtent: 210,
                                        ),
                                        itemBuilder: (context, index) {
                                          if (adres.isNotEmpty) {
                                            _adresbilgi = adres[index];
                                          }
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: ClayContainer(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            (tumurunler
                                                                    .isNotEmpty)
                                                                ? _adresbilgi[
                                                                        "Adres Adı"]
                                                                    .toString()
                                                                : "",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          )),
                                                        ],
                                                      ),
                                                      const Divider(
                                                          height: 20,
                                                          color: Colors.black),
                                                      Text(
                                                        (tumurunler.isNotEmpty)
                                                            ? _adresbilgi["Adı"]
                                                                    .toString() +
                                                                " " +
                                                                _adresbilgi[
                                                                        "Soyadı"]
                                                                    .toString()
                                                            : "",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                        (tumurunler.isNotEmpty)
                                                            ? _adresbilgi[
                                                                    "Adres"]
                                                                .toString()
                                                            : "",
                                                        style: const TextStyle(
                                                            fontSize: 13),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        (tumurunler.isNotEmpty)
                                                            ? _adresbilgi[
                                                                        "İlçe"]
                                                                    .toString() +
                                                                "/" +
                                                                _adresbilgi[
                                                                        "İl"]
                                                                    .toString()
                                                            : "",
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        (tumurunler.isNotEmpty)
                                                            ? _adresbilgi[
                                                                    "Telefon"]
                                                                .toString()
                                                            : "",
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      MaterialButton(
                                                        onPressed: () {
                                                          _secilenadres = index;
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          alignment:
                                                              Alignment.center,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: _secilenadres ==
                                                                        index
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .amber,
                                                                width:
                                                                    _secilenadres ==
                                                                            index
                                                                        ? 2
                                                                        : 0),
                                                            color: Colors.amber,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Text(
                                                            _secilenadres ==
                                                                    index
                                                                ? "Adres Seçildi ✓"
                                                                : "Adresi Seç",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ClayContainer(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: const [
                                          Expanded(
                                              child: Text(
                                            "Adres Ekle",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          )),
                                        ],
                                      ),
                                      const Divider(
                                          height: 20, color: Colors.black),
                                      Container(
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.add_location_alt_sharp,
                                          size: 40,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            Navigator.pushNamed(
                                                context, '/adresekle',
                                                arguments: {});
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.amber, width: 0),
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          alignment: Alignment.center,
                                          height: 30,
                                          child: const Text(
                                            "Adres Ekle",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
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
                            height: 10,
                          ),
                          MaterialButton(
                            onPressed: () {},
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text(
                                "Satın Al",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
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

  Future<int> adresSayisiGetir() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final String _userId = FirebaseAuth.instance.currentUser!.uid;
    await _firestore
        .collection("users/$_userId/Adresler")
        .get()
        .then((snapshot) {
      _adressayisi = snapshot.docs.length;
    });
    return _adressayisi;
  }

  adresGetir() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final String _userId = FirebaseAuth.instance.currentUser!.uid;
    await for (var snapshot
        in _firestore.collection('users/$_userId/Adresler').snapshots()) {
      for (var message in snapshot.docs) {
        setState(() {
          adres.add(message.data());
          adresAdlari.add(message.data()["Adres Adı"].toString());
        });
      }
    }
  }

  List<String> adresAdlari = [];

  urunGetir() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final String _userId = FirebaseAuth.instance.currentUser!.uid;
      await for (var snapshot in _firestore
          .collection('users/$_userId/SepettekiUrunler')
          .snapshots()) {
        for (var message in snapshot.docs) {
          tumurunler.add(message.data());
        }
        hesapla();
      }
      await _firestore
          .collection("users/$_userId/SepettekiUrunler")
          .get()
          .then((snapshot) => _toplamurun = snapshot.docs.length);

      // ignore: unused_element
    } else {
      var boxs = Hive.box("SepettekiUrunler");
      // ignore: unused_local_variable
      for (var message in boxs.values) {
        tumurunler.add(message);
      }
      _toplamurun = tumurunler.length;
      hesapla();
    }
  }

  urunSayisiGetir() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final String _userId = FirebaseAuth.instance.currentUser!.uid;
      await _firestore
          .collection("users/$_userId/SepettekiUrunler")
          .get()
          .then((snapshot) {
        setState(() {
          _toplamurun = snapshot.docs.length;
        });
      });
      return _toplamurun;
    } else {}
  }

  double toplamtutar = 0;
  hesapla() {
    if (tumurunler.isNotEmpty) {
      for (var message in tumurunler) {
        toplamtutar += message["Fiyat"] * message["Adet"];
      }
    }
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
          maxCrossAxisExtent: _toplamurun % 2 == 0 ? 500 : 1000,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          mainAxisExtent: 120,
        ),
        itemBuilder: (context, index) {
          if (tumurunler.isNotEmpty) {
            _bilgi = tumurunler[index];
          }
          String? _secilenAdres;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
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
                        Column(mainAxisAlignment: MainAxisAlignment.center,
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
                              Visibility(
                                visible: !_ayniadres,
                                child: Row(
                                  children: [
                                    // ignore: prefer_const_constructors
                                    Text(
                                      "Adres Adı:",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: _secilenadresler[index] == null
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 25,
                                      //width: 70,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: DropdownButton<String>(
                                          //isExpanded: true,
                                          // iconSize: 15,
                                          underline: Container(
                                            height: 0,
                                          ),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                          hint: Text(
                                            "Seçiniz",
                                            style: TextStyle(
                                                color:
                                                    _secilenadresler[index] ==
                                                            null
                                                        ? Colors.red
                                                        : Colors.black,
                                                fontSize: 14),
                                          ),
                                          items: adresAdlari
                                              .map(
                                                (String oAnkiAdres) =>
                                                    DropdownMenuItem(
                                                  child: Text(oAnkiAdres),
                                                  value: oAnkiAdres,
                                                ),
                                              )
                                              .toList(),
                                          value: _secilenadresler[index],
                                          onChanged: (String? yeni) {
                                            if (yeni!.isEmpty) {
                                            } else {
                                              setState(() {
                                                _secilenAdres = yeni;
                                                _secilenadresler.addAll({
                                                  index:
                                                      _secilenAdres.toString()
                                                });
                                              });
                                            }
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
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
          );
        });
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
    if (FirebaseAuth.instance.currentUser != null) {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final String _userId = FirebaseAuth.instance.currentUser!.uid;
      await _firestore
          .collection("users/$_userId/SepettekiUrunler")
          .doc(_isim)
          .delete();
      Navigator.of(context).pop();
    } else {
      var box = Hive.box("SepettekiUrunler");
      box.delete(_isim);
      Navigator.of(context).pop();
    }
  }
}
