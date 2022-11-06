import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_proje_1/altbar.dart';
import 'package:flutter_proje_1/altmenu.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import 'appbar.dart';

// ignore: camel_case_types
class urun extends StatefulWidget {
  final String isim;
  final double fiyat;

  const urun({Key? key, required this.isim, required this.fiyat})
      : super(key: key);

  @override
  State<urun> createState() => _urunState();
}

// ignore: camel_case_types
class _urunState extends State<urun> {
  final CarouselController _controller = CarouselController();
  Map urunler = {};
  int a = 0;
  int _toplamurun = 0;
  final controller = ScrollController();
  int _secilenresim = 0;
  int _secilenkutu = 50;
  int _urunsayi = 1;
  Timer? _timer;
  late double _progress;
  // ignore: non_constant_identifier_names
  var map1 = {
    0: "73 cm",
    1: "Normal",
    2: "%100 cotton",
    3: "-",
    4: "-",
    5: "Yok",
  };
  var map2 = {
    0: "Boy:",
    1: "Kalıp:",
    2: "Kumaş:",
    3: "Özellik:",
    4: "Aksesuar:",
    5: "Likra:",
  };
  var bedenler = {
    0: "S",
    1: "M",
    2: "L",
    3: "XL",
  };
  Map<int, int> bedensayi = {
    0: 12,
    1: 6,
    2: 3,
    3: 20,
  };
  var zaman = DateTime.now();
  var eklenecekzaman = const Duration(days: 5);
  Map<int, String> weekdayName = {
    1: "Pazartesi",
    2: "Salı",
    3: "Çarşamba",
    4: "Perşembe",
    5: "Cuma",
    6: "Cumartesi",
    7: "Pazar"
  };

  @override
  void initState() {
    asdf();
    urunGetir();
    zaman = zaman.add(eklenecekzaman);
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

  @override
  Widget build(BuildContext context) {
    void configLoading() {
      EasyLoading.instance
        ..displayDuration = const Duration(milliseconds: 2000)
        ..indicatorType = EasyLoadingIndicatorType.fadingCircle
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorSize = 45.0
        ..radius = 10.0
        ..progressColor = Colors.white
        ..backgroundColor = Colors.amber
        ..indicatorColor = Colors.white
        ..textColor = Colors.white
        ..maskColor = Colors.black
        ..userInteractions = true
        ..dismissOnTap = false;
    }

    configLoading();
    // ignore: unused_local_variable
    var _renk = Colors.white30;
    return Scaffold(
      bottomNavigationBar: const AltBar(
        sayi: 5,sayim:1
      ),
      body: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            const kayanappbar(),
            SliverList(
                delegate: SliverChildListDelegate([
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent:
                        MediaQuery.of(context).size.width <= 420 ? 2000 : 1300),
                itemBuilder: (context, index) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MediaQuery.of(context).size.width <= 420
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 300,
                                  height: 445,
                                  child: CarouselSlider(
                                    carouselController: _controller,
                                    options: CarouselOptions(
                                        viewportFraction: 1,
                                        height: 445,
                                        autoPlay: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 10),
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _secilenresim = index;
                                            if (_secilenresim < 5) {
                                              uruncik();
                                            } else {
                                              urunin();
                                            }
                                          });
                                        }),
                                    items: imgList.map((imgAsset) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return PinchZoom(
                                            resetDuration: const Duration(
                                                milliseconds: 100),
                                            maxScale: 3,
                                            child: Container(
                                              width: 300,
                                              height: 445,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 10),
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                              child: Image.asset(
                                                imgAsset,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  height: 430,
                                  width:
                                      MediaQuery.of(context).size.width <= 420
                                          ? 50
                                          : 50,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      height: 5,
                                    ),
                                    controller: controller,
                                    shrinkWrap: true,
                                    itemCount: resimler.length,
                                    itemBuilder: ((context, index) {
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _secilenresim = index;
                                                _controller
                                                    .animateToPage(index);
                                              });
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: _secilenresim ==
                                                                index
                                                            ? Colors
                                                                .orangeAccent
                                                            : Colors.white)),
                                                height: 81.4,
                                                child: Image.asset(
                                                  resimler[index].toString(),
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      MediaQuery.of(context).size.width > 420,
                                  child: const SizedBox(
                                    width: 10,
                                  ),
                                ),
                                Visibility(
                                    visible:
                                        MediaQuery.of(context).size.width > 420,
                                    child: SizedBox(
                                      height: 500,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                372,
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    widget.isim,
                                                    //"Açıkfüme Pantolon Mom Yırtıklı",
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    widget.fiyat.toString() +
                                                        " TL",
                                                    //"146.00 TL",
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .orangeAccent),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 40,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        bedenler.keys.length,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: (() {
                                                              setState(() {
                                                                _secilenkutu =
                                                                    index;
                                                                _urunsayi = 1;
                                                              });
                                                            }),
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              height: 40,
                                                              width: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: _secilenkutu ==
                                                                        index
                                                                    ? Colors
                                                                        .orange
                                                                    : Colors
                                                                        .white,
                                                                border:
                                                                    Border.all(
                                                                  width: 1,
                                                                  color: _secilenkutu ==
                                                                          index
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .grey,
                                                                ),
                                                              ),
                                                              child: Text(
                                                                bedenler[index]
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color: _secilenkutu ==
                                                                          index
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          )
                                                        ],
                                                      );
                                                    }),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                width: 1,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          height: 40,
                                                          width: 190,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text("$_urunsayi",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                  )),
                                                              SizedBox(
                                                                width: 70,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          if (_urunsayi >
                                                                              1) {
                                                                            _urunsayi--;
                                                                          }
                                                                        });
                                                                      },
                                                                      child: const Icon(
                                                                          Icons
                                                                              .remove),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        int?
                                                                            asdf =
                                                                            bedensayi[_secilenkutu];
                                                                        setState(
                                                                            () {
                                                                          if (asdf ==
                                                                              null) {
                                                                            _showMyDialog();
                                                                          } else if (_urunsayi <
                                                                              asdf) {
                                                                            _urunsayi++;
                                                                          }
                                                                        });
                                                                      },
                                                                      child: const Icon(
                                                                          Icons
                                                                              .add),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          begeniekle();
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          height: 40,
                                                          child: const Text(
                                                            "Beğen",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (_secilenkutu < 20) {
                                                      sepetekle();
                                                    } else {
                                                      _showMyDialog();
                                                    }
                                                  },
                                                  child: Container(
                                                    color: Colors.orange,
                                                    alignment: Alignment.center,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    height: 40,
                                                    child: const Text(
                                                      "Sepete Ekle",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Visibility(
                                                  visible: _secilenkutu < 10,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        "Bu ürünün ",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    70,
                                                                    70,
                                                                    70)),
                                                      ),
                                                      Text(
                                                        bedenler[_secilenkutu]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    70,
                                                                    70,
                                                                    70),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const Text(
                                                        " bedeninden en fazla ",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    70,
                                                                    70,
                                                                    70)),
                                                      ),
                                                      Text(
                                                        bedensayi[_secilenkutu]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    70,
                                                                    70,
                                                                    70),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const Text(
                                                        "adet satın alabilirsiniz.",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    70,
                                                                    70,
                                                                    70)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        "Şimdi Sipariş Verirseniz Tahmini Teslim Tarihi: ",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    70,
                                                                    70,
                                                                    70)),
                                                      ),
                                                      Text(
                                                        zaman.day.toString() +
                                                            "." +
                                                            zaman.month
                                                                .toString() +
                                                            "." +
                                                            zaman.year
                                                                .toString() +
                                                            " " +
                                                            weekdayName[zaman
                                                                    .weekday]
                                                                .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    70,
                                                                    70,
                                                                    70),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: const Divider(
                                                    height: 3,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: const Text(
                                                      "Ürün Özellikleri:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  //color: Colors.red,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: map1.length,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                map2[index]
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        13.5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                map1[index]
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        13.5),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 7,
                                                          )
                                                        ],
                                                      );
                                                    }),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                            Visibility(
                              visible: MediaQuery.of(context).size.width < 420,
                              child: Column(children: [
                                const SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.isim,
                                    //"Açıkfüme Pantolon Mom Yırtıklı",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.fiyat.toString() + " TL",
                                    //"146.00 TL",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orangeAccent),
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 10),
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: bedenler.keys.length,
                                    itemBuilder: ((context, index) {
                                      return Row(
                                        children: [
                                          GestureDetector(
                                            onTap: (() {
                                              setState(() {
                                                _secilenkutu = index;
                                                _urunsayi = 1;
                                              });
                                            }),
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: _secilenkutu == index
                                                    ? Colors.orange
                                                    : Colors.white,
                                                border: Border.all(
                                                  width: 1,
                                                  color: _secilenkutu == index
                                                      ? Colors.black
                                                      : Colors.grey,
                                                ),
                                              ),
                                              child: Text(
                                                bedenler[index].toString(),
                                                style: TextStyle(
                                                  color: _secilenkutu == index
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.grey),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          width: 190,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("$_urunsayi",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  )),
                                              SizedBox(
                                                width: 70,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (_urunsayi > 1) {
                                                            _urunsayi--;
                                                          }
                                                        });
                                                      },
                                                      child: const Icon(
                                                          Icons.remove),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        int? asdf = bedensayi[
                                                            _secilenkutu];
                                                        setState(() {
                                                          if (asdf == null) {
                                                            _showMyDialog();
                                                          } else if (_urunsayi <
                                                              asdf) {
                                                            _urunsayi++;
                                                          }
                                                        });
                                                      },
                                                      child:
                                                          const Icon(Icons.add),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          begeniekle();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.red),
                                          ),
                                          height: 40,
                                          child: const Text(
                                            "Beğen",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_secilenkutu < 20) {
                                      sepetekle();
                                    } else {
                                      _showMyDialog();
                                    }
                                  },
                                  child: Container(
                                    color: Colors.orange,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: 40,
                                    child: const Text(
                                      "Sepete Ekle",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Visibility(
                                  visible: _secilenkutu < 10,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Bu ürünün ",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Color.fromARGB(
                                                255, 70, 70, 70)),
                                      ),
                                      Text(
                                        bedenler[_secilenkutu].toString(),
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color:
                                                Color.fromARGB(255, 70, 70, 70),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        " bedeninden en fazla ",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Color.fromARGB(
                                                255, 70, 70, 70)),
                                      ),
                                      Text(
                                        bedensayi[_secilenkutu].toString(),
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color:
                                                Color.fromARGB(255, 70, 70, 70),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        " adet satın alabilirsiniz.",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Color.fromARGB(
                                                255, 70, 70, 70)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Şimdi Sipariş Verirseniz Tahmini Teslim Tarihi: ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(
                                                255, 70, 70, 70)),
                                      ),
                                      Text(
                                        zaman.day.toString() +
                                            "." +
                                            zaman.month.toString() +
                                            "." +
                                            zaman.year.toString() +
                                            " " +
                                            weekdayName[zaman.weekday]
                                                .toString(),
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 70, 70, 70),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const Divider(
                                    height: 3,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Ürün Özellikleri:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                const SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  //color: Colors.red,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: map1.length,
                                    itemBuilder: ((context, index) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                map2[index].toString(),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                map1[index].toString(),
                                                style: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          )
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const Divider(
                                    height: 3,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                              ]),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 6,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
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
                                                      isim: isimList[index]
                                                          .toString(),
                                                      fiyat: fiyatList[index],
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          //  decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5),
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
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 3),
                                                  child: SizedBox(
                                                    child: Text(
                                                      //"URUN",
                                                      isimList[index]
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 3),
                                                  child: SizedBox(
                                                    child: Text(
                                                        /*"Urun Fiyat", */ fiyatList[
                                                                    index]
                                                                .toString() +
                                                            " TL",
                                                        textAlign:
                                                            TextAlign.start,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .orangeAccent,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            const altmenu(),
                          ],
                        ),
                      );
                    }),
                    itemCount: 1,
                  );
                },
              )
            ]))
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lütfen Beden Seçiniz!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Lütfen beden seçiniz!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Kapat',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  urunGetir() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final String _userId = FirebaseAuth.instance.currentUser!.uid;
      await for (var snapshot in _firestore
          .collection('users/$_userId/SepettekiUrunler')
          .snapshots()) {
        for (var message in snapshot.docs) {
          urunler.addAll(message.data());
        }
      }
      await _firestore
          .collection("users/$_userId/SepettekiUrunler")
          .get()
          .then((snapshot) => _toplamurun = snapshot.docs.length);

      // ignore: unused_element
    } else {
      var box = Hive.box("SepettekiUrunler");
      for (var message in box.values) {
        urunler.addAll(message);
      }
      for (var element in box.keys) {
        _toplamurun++;
      }
    }
  }

  void begeniekle() async {
    if (FirebaseAuth.instance.currentUser != null) {
      try {
        String _userId = FirebaseAuth.instance.currentUser!.uid;
        FirebaseFirestore _firestore = FirebaseFirestore.instance;
        Map<String, dynamic> _eklenecekUrun = <String, dynamic>{};
        _eklenecekUrun["Adı"] = widget.isim;
        _eklenecekUrun["Fiyat"] = widget.fiyat;
        await _firestore
            .collection("users/$_userId/BegenilenUrunler")
            .doc(widget.isim)
            .set(_eklenecekUrun, SetOptions(merge: true));
        ToastMessageBegeni();
        // ignore: empty_catches
      } catch (e) {}
    } else {
      var box2 = Hive.box("BegenilenUrunler");
      try {
        Map<String, dynamic> _eklenecekUrun = <String, dynamic>{};
        _eklenecekUrun["Adı"] = widget.isim;
        _eklenecekUrun["Fiyat"] = widget.fiyat;
        await box2.put(widget.isim, _eklenecekUrun);
        ToastMessageBegeni();
        // ignore: empty_catches
      } catch (e) {}
    }
  }

  void sepetekle() async {
    if (FirebaseAuth.instance.currentUser != null) {
      urunGetir();
      try {
        String _userId = FirebaseAuth.instance.currentUser!.uid;
        FirebaseFirestore _firestore = FirebaseFirestore.instance;
        Map<String, dynamic> _eklenecekUrun = <String, dynamic>{};
        await _firestore
            .collection("users/$_userId/SepettekiUrunler")
            .get()
            .then((snapshot) => _toplamurun = snapshot.docs.length);
        for (int i = 1; i <= _toplamurun; i++) {
          if (urunler != {} &&
              urunler["Adı"] == widget.isim &&
              urunler["Beden"] == bedenler[_secilenkutu]) {
            a = 1;
            _eklenecekUrun["Adet"] = urunler["Adet"] + _urunsayi;
            if (_eklenecekUrun["Adet"] <= bedensayi[_secilenkutu]) {
              await _firestore
                  .collection("users/$_userId/SepettekiUrunler")
                  .doc("${widget.isim} ${bedenler[_secilenkutu]} Beden")
                  .set(_eklenecekUrun, SetOptions(merge: true));
              ToastMessage();
            } else {
              _Hatastok();
            }
          }
        }
        if (a != 1) {
          _toplamurun++;
          _eklenecekUrun["Adı"] = widget.isim;
          _eklenecekUrun["Fiyat"] = widget.fiyat;
          _eklenecekUrun["Beden"] = bedenler[_secilenkutu];
          _eklenecekUrun["Adet"] = _urunsayi;
          await _firestore
              .collection("users/$_userId/SepettekiUrunler")
              .doc("${widget.isim} ${bedenler[_secilenkutu]} Beden")
              .set(_eklenecekUrun, SetOptions(merge: true));
          ToastMessage();
        }
      } catch (e) {
        _Hata();
      }
      a = 0;
    } else {
      urunGetir();
      var box = Hive.box("SepettekiUrunler");
      Map<String, dynamic> _eklenecekUrun = <String, dynamic>{};
      try {
        // ignore: unused_local_variable
        for (var element in box.keys) {
          _toplamurun++;
        }
        for (int i = 1; i <= _toplamurun; i++) {
          if (urunler != {} &&
              urunler["Adı"] == widget.isim &&
              urunler["Beden"] == bedenler[_secilenkutu]) {
            a = 1;
            _eklenecekUrun["Adet"] = urunler["Adet"] + _urunsayi;
            _eklenecekUrun["Adı"] = widget.isim;
            _eklenecekUrun["Fiyat"] = widget.fiyat;
            _eklenecekUrun["Beden"] = bedenler[_secilenkutu];
            if (_eklenecekUrun["Adet"] <= bedensayi[_secilenkutu]) {
              await box.put("${widget.isim} ${bedenler[_secilenkutu]} Beden",
                  _eklenecekUrun);
              ToastMessage();
            } else {
              _Hatastok();
            }
          }
        }
        if (a != 1) {
          _toplamurun++;
          _eklenecekUrun["Adı"] = widget.isim;
          _eklenecekUrun["Fiyat"] = widget.fiyat;
          _eklenecekUrun["Beden"] = bedenler[_secilenkutu];
          _eklenecekUrun["Adet"] = _urunsayi;
          await box.put(
              "${widget.isim} ${bedenler[_secilenkutu]} Beden", _eklenecekUrun);
          ToastMessage();
        }
      } catch (e) {
        _Hata();
      }
      a = 0;
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> _Hata() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bir Hata Meydana Geldi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Bir Hata Meydana Geldi.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Kapat',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> _Hatastok() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hata!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Sepetinizdeki ${widget.isim} İsimli Ürünün ${bedenler[_secilenkutu]} Bedeni İçin Maksimum Stok Adedi ${bedensayi[_secilenkutu]}.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Kapat',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List imgList = [
    "assets/images/urunresim/urun1.jpeg",
    "assets/images/urunresim/urun2.jpeg",
    "assets/images/urunresim/urun3.jpeg",
    "assets/images/urunresim/urun4.jpeg",
    "assets/images/urunresim/urun5.jpeg",
    "assets/images/urunresim/urun6.jpeg",
    "assets/images/urunresim/urun7.jpeg",
    "assets/images/urunresim/urun8.jpeg",
    "assets/images/urunresim/urun9.jpeg",
    "assets/images/urunresim/urun10.jpeg",
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  // ignore: non_constant_identifier_names
  Future<void> ToastMessage() async {
    {
      _progress = 0;
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(milliseconds: 100),
          (Timer timer) async {
        await EasyLoading.showProgress(_progress,
            status: '${(_progress * 100).toStringAsFixed(0)}%');
        _progress += 0.3;
        if (_progress >= 1) {
          _timer?.cancel();
          EasyLoading.showSuccess('Ürün Sepete Başarıyla Eklendi!');
        }
      });
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> ToastMessageBegeni() async {
    {
      _progress = 0;
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(milliseconds: 100),
          (Timer timer) async {
        await EasyLoading.showProgress(_progress,
            status: '${(_progress * 100).toStringAsFixed(0)}%');
        _progress += 0.3;
        if (_progress >= 1) {
          _timer?.cancel();
          EasyLoading.showSuccess('Ürün Beğenilenlere Başarıyla Eklendi!');
        }
      });
    }
  }

  void urunin() {
    final end = controller.position.maxScrollExtent;
    controller.jumpTo(end);
  }

  void uruncik() {
    const end = 0.0;
    controller.jumpTo(end);
  }
}

List resimler = [
  "assets/images/urunresim/urun1.jpeg",
  "assets/images/urunresim/urun2.jpeg",
  "assets/images/urunresim/urun3.jpeg",
  "assets/images/urunresim/urun4.jpeg",
  "assets/images/urunresim/urun5.jpeg",
  "assets/images/urunresim/urun6.jpeg",
  "assets/images/urunresim/urun7.jpeg",
  "assets/images/urunresim/urun8.jpeg",
  "assets/images/urunresim/urun9.jpeg",
  "assets/images/urunresim/urun10.jpeg",
];
/*List bedenler = [
  "S"
  "M",
  "L",
  "XL",
];*/
List isimList = [
  "Gözlük Siyah Aksesuar",
  "Krem Cam Topuklu Ayakkabı Cm",
  "Sarı Tek Bustiyer Askılı Omuz",
  "Gabardin Çıtçıtlı Mint Ceket",
  "Sandy Elbise Siyah Kolları Tüllü",
  "Salaş Kot Siyah Pantolon",
];

List fiyatList = [
  71.00,
  214.00,
  29.00,
  132.00,
  161.00,
  154.00,
];
