import 'dart:async';

import 'package:clay_containers/widgets/clay_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proje_1/altbar.dart';
import 'package:flutter_proje_1/appbar.dart';
import 'package:flutter_proje_1/urun.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'altmenu.dart';

// ignore: camel_case_types
class begeniSayfasi extends StatefulWidget {
  const begeniSayfasi({Key? key}) : super(key: key);

  @override
  State<begeniSayfasi> createState() => _begeniSayfasiState();
}

// ignore: camel_case_types
class _begeniSayfasiState extends State<begeniSayfasi> {
  int _toplamurun = 0;
  List<Map> tumurunler = [];
  @override
  void initState() {
    asdf();
    urunSayisiGetir();
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

  int sayfano = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AltBar(
        sayi: sayfano,
        sayim: 1,
      ),
      body: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            const kayanappbar(),
            SliverList(
                delegate: SliverChildListDelegate([
              Visibility(
                visible: _toplamurun != 0,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Beğenilen Ürünler",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        begenilenUrunler(),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          color: Colors.amber,
                          margin: const EdgeInsets.all(10),
                          child: const Text(
                            "REKLAM ALANI",
                            textAlign: TextAlign.center,
                          ),
                          height: 300,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const altmenu(),
                      ],
                    );
                  }),
                  itemCount: 1,
                ),
              ),
              Visibility(
                visible: _toplamurun == 0,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 150,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2 - 170,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 35),
                        alignment: Alignment.center,
                        child: ClayContainer(
                          height: 210,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const Text(
                                  "Beğenilen Ürünler",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Divider(height: 20, color: Colors.grey),
                                Container(
                                  alignment: Alignment.center,
                                  height: 150,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        "Beğeniler Listesi Şu Anlık Boş.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 35),
                                        child: MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(
                                              context,
                                              '/anasayfa',
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 35,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: const Text(
                                              "Alışverişe Başla",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]))
          ],
        ),
      ),
    );
  }

  urunSayisiGetir() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final String _userId = FirebaseAuth.instance.currentUser!.uid;
      await _firestore
          .collection("users/$_userId/BegenilenUrunler")
          .get()
          .then((snapshot) {
        setState(() {});
        _toplamurun = snapshot.docs.length;
      });
      return _toplamurun;
    }
  }

  urunGetir() async {
    /*
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final String _userId = FirebaseAuth.instance.currentUser!.uid;
    await for (var snapshot in _firestore
        .collection('users/$_userId/BegenilenUrunler')
        .snapshots()) {
      for (var message in snapshot.docs) {
        tumurunler.add(message.data());
      }
    }
    */
    if (FirebaseAuth.instance.currentUser != null) {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final String _userId = FirebaseAuth.instance.currentUser!.uid;
      await for (var snapshot in _firestore
          .collection('users/$_userId/BegenilenUrunler')
          .snapshots()) {
        for (var message in snapshot.docs) {
          tumurunler.add(message.data());
        }
      }
      await _firestore
          .collection("users/$_userId/BegenilenUrunler")
          .get()
          .then((snapshot) => _toplamurun = snapshot.docs.length);

      // ignore: unused_element
    } else {
      var box = Hive.box("BegenilenUrunler");
      for (var message in box.values) {
        tumurunler.add(message);
      }
      for (var element in box.keys) {
        _toplamurun++;
      }
    }
  }

  Widget begenilenUrunler() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _toplamurun,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 255,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: 290),
          itemBuilder: (context, index) {
            return ClayContainer(
              borderRadius: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        // ignore: prefer_const_constructors
                        builder: (context) => urun(
                              isim: tumurunler[index]["Adı"].toString(),
                              fiyat: tumurunler[index]["Fiyat"],
                            )),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
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
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  child: Image.asset(
                                    "assets/images/urun.jpeg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: SizedBox(
                            child: Text(
                              (tumurunler.isNotEmpty)
                                  ? tumurunler[index]["Adı"].toString()
                                  : "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: SizedBox(
                            child: Text(
                                (tumurunler.isNotEmpty)
                                    ? tumurunler[index]["Fiyat"].toString() +
                                        " TL"
                                    : "",
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            _silmePopUp(tumurunler[index]["Adı"].toString());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              color: const Color.fromARGB(255, 255, 178, 62),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text("Ürünü Kaldır"),
                                Icon(
                                  Icons.delete,
                                  size: 20,
                                )
                              ],
                            ),
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

  Future<void> _silmePopUp(String isim) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ürünü Beğenilenlerden Kaldır'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    '$isim İsimli Ürünü Beğenilerinizden Kaldırmak İstediğinize Emin Misiniz?'),
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
                String urunad = isim;
                urunSil(urunad);
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
          .collection("users/$_userId/BegenilenUrunler")
          .doc(_isim)
          .delete();
      Navigator.of(context).pop();
    }
    var box = Hive.box("BegenilenUrunler");
    box.delete(_isim);
    Navigator.of(context).pop();
  }
}
