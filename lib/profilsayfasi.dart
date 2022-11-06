import 'dart:async';

import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_proje_1/altbar.dart';
import 'package:flutter_proje_1/appbar.dart';
import 'package:flutter_proje_1/isimgetir.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ProfilSayfasi extends StatefulWidget {
  const ProfilSayfasi({Key? key}) : super(key: key);
  @override
  State<ProfilSayfasi> createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  @override
  void initState() {
    asdf();
    auth = FirebaseAuth.instance;
    bilgiGetir();
    adresSayisiGetir();
    isminiGetir();
    ismiGetir();
    adresGetir();
    // ignore: unrelated_type_equality_checks
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

  // ignore: prefer_final_fields
  bool menuGorunum = false;
  List<Map> adres = [];
  int _adressayisi = 0;
  bool _hesabim = true;
  bool _siparislerim = false;
  bool _hesaphareketlerim = false;
  bool _bilgilerim = false;
  // ignore: unused_field
  bool _adreslerim = false;
  bool _ad = true;
  bool _soyad = true;
  bool _firmaadi = false;
  bool _adres = false;
  bool _ilce = false;
  bool _il = false;
  bool _vergidairesi = false;
  bool _vergino = false;
  bool _ibanunvan = false;
  bool _ibanno = false;
  bool _tckimlikno = false;
  // ignore: avoid_init_to_null
  String? _adi;
  String? _soyadi;
  String? _firmaninadi;
  String? _adresi;
  String? _ilcesi;
  String? _ili;
  String? _verginindairesi;
  String? _vergininno;
  String? _ibaninunvan;
  String? _ibaninno;
  String? _tckimliknumara;
  String _adsoyad = "";
  // ignore: prefer_final_fields
  String _mail = "";
  // ignore: prefer_final_fields
  String _numara = "";
  bool _kampanyasecildi = false;
  Timer? _timer;
  late double _progress;
  int sayi = 1;

  //late FirebaseAuth auth;
  FirebaseAuth auth = FirebaseAuth.instance;

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
    return Scaffold(
      bottomNavigationBar: const AltBar(
        sayi: 4,sayim:1
      ),
      body: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            const kayanappbar(),
            SliverList(
                delegate: SliverChildListDelegate([
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 35),
                        height: 50,
                        child: ClayContainer(
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: const Icon(Icons.person)),
                                    /*Visibility(
                                      visible: sayi == 1,
                                      child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: showName(sayi)),
                                    ),*/
                                    // Visibility(
//visible: sayi != 1,
                                    /* child: */ Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          _adsoyad,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )),
                                    //  ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                    width: 40,
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Icon(Icons.dehaze)),
                                onTap: () {
                                  setState(() {
                                    menuGorunum = !menuGorunum;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: menuGorunum,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: const Text(
                                    "Hesabım",
                                    textAlign: TextAlign.start,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _adreslerim = false;
                                      _bilgilerim = false;
                                      _hesabim = true;
                                      _hesaphareketlerim = false;
                                      _siparislerim = false;
                                    });
                                  }),
                              MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: const Text("Siparişlerim"),
                                  onPressed: () {
                                    setState(() {
                                      _adreslerim = false;
                                      _bilgilerim = false;
                                      _hesabim = false;
                                      _hesaphareketlerim = false;
                                      _siparislerim = true;
                                    });
                                  }),
                              MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: const Text("Hesap Hareketlerim"),
                                  onPressed: () {
                                    setState(() {
                                      _adreslerim = false;
                                      _bilgilerim = false;
                                      _hesabim = false;
                                      _hesaphareketlerim = true;
                                      _siparislerim = false;
                                    });
                                  }),
                              MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: const Text("Bilgilerim"),
                                  onPressed: () {
                                    setState(() {
                                      _adreslerim = false;
                                      _bilgilerim = true;
                                      _hesabim = false;
                                      _hesaphareketlerim = false;
                                      _siparislerim = false;
                                    });
                                  }),
                              MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: const Text("Adreslerim"),
                                  onPressed: () {
                                    setState(() {
                                      _adreslerim = true;
                                      _bilgilerim = false;
                                      _hesabim = false;
                                      _hesaphareketlerim = false;
                                      _siparislerim = false;
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 20,
                        color: Colors.grey,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 35),
                        child: MaterialButton(
                          onPressed: () {
                            _cikis();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 170,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              "Çıkış Yap",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 20,
                        color: Colors.grey,
                      ),
                      MenuGoster(),
                    ],
                  );
                }),
                itemCount: 1,
              )
            ]))
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MenuGoster() {
    if (_hesabim == true) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 35),
        child: ClayContainer(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  "Hesabım",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Divider(height: 20, color: Colors.grey),
                const Text(
                    "Hesabım sayfasından siparişlerinizi ve iade değişim işlemlerinizi takip edebilir; üyelik bilgisi güncelleme, şifre ve adres değişikliği gibi hesap ayarlarınızı kolayca yapabilirsiniz."),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _adreslerim = false;
                        _bilgilerim = false;
                        _hesabim = false;
                        _hesaphareketlerim = false;
                        _siparislerim = true;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: const Text(
                        "Siparişlerim",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _adreslerim = true;
                        _bilgilerim = false;
                        _hesabim = false;
                        _hesaphareketlerim = false;
                        _siparislerim = false;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: const Text(
                        "Adreslerim",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _adreslerim = false;
                        _bilgilerim = true;
                        _hesabim = false;
                        _hesaphareketlerim = false;
                        _siparislerim = false;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: const Text(
                        "Bilgilerim",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (_siparislerim == true) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 35),
        child: ClayContainer(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  "Siparişlerim",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Divider(height: 20, color: Colors.grey),
                Container(
                  alignment: Alignment.center,
                  height: 120,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: const Text(
                    "Henüz Siparişiniz Bulunmamaktadır.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (_hesaphareketlerim == true) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 35),
        child: ClayContainer(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  "Hesap Hareketlerim",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Divider(height: 20, color: Colors.grey),
              ],
            ),
          ),
        ),
      );
    } else if (_bilgilerim == true) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 35),
        child: ClayContainer(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  "Bilgilerim",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Divider(height: 20, color: Colors.grey),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Colors.black,
                  maxLines: 1,
                  initialValue: _adi,
                  decoration: const InputDecoration(
                    labelText: "Adınız",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    border: OutlineInputBorder(),
                  ),
                  validator: (deger) {
                    if (deger!.isEmpty) {
                      _ad = false;
                      return "Ad Kısmı Boş Bırakılamaz!";
                    } else {
                      _ad = true;
                      _adi = deger;
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Colors.black,
                  maxLines: 1,
                  initialValue: _soyadi,
                  decoration: const InputDecoration(
                    labelText: "Soyadınız",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    border: OutlineInputBorder(),
                  ),
                  validator: (deger) {
                    if (deger!.isEmpty) {
                      _soyad = false;
                      return "Soyad Kısmı Boş Bırakılamaz!";
                    } else {
                      _soyad = true;
                      _soyadi = deger;
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  readOnly: true,
                  cursorColor: Colors.black,
                  maxLines: 1,
                  initialValue: _numara,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    floatingLabelStyle: TextStyle(
                        backgroundColor: Color.fromARGB(255, 240, 240, 240),
                        color: Colors.black),
                    fillColor: Color.fromARGB(255, 179, 179, 179),
                    filled: true,
                    labelText: "Telefon Numarası",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  readOnly: true,
                  cursorColor: Colors.black,
                  maxLines: 1,
                  initialValue: _mail,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    floatingLabelStyle: TextStyle(
                        backgroundColor: Color.fromARGB(255, 240, 240, 240),
                        color: Colors.black),
                    fillColor: Color.fromARGB(255, 179, 179, 179),
                    filled: true,
                    labelText: "E-Mail",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(height: 20, color: Colors.grey),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Colors.black,
                  maxLines: 1,
                  initialValue: _firmaninadi == "null" ? null : _firmaninadi,
                  decoration: const InputDecoration(
                    labelText: "Firma Adı",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    border: OutlineInputBorder(),
                  ),
                  validator: (deger) {
                    if (deger!.isEmpty) {
                      _firmaadi = false;
                      return "Firma Adı Kısmı Boş Bırakılamaz!";
                    } else {
                      _firmaadi = true;
                      _firmaninadi = deger;
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Colors.black,
                  maxLines: 1,
                  initialValue: _adresi == "null" ? null : _adresi,
                  decoration: const InputDecoration(
                    labelText: "Adres",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    border: OutlineInputBorder(),
                  ),
                  validator: (deger) {
                    if (deger!.isEmpty) {
                      _il = false;
                      return "Adres Kısmı Boş Bırakılamaz!";
                    } else {
                      _adres = true;
                      _adresi = deger;
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Colors.black,
                  maxLines: 1,
                  initialValue: _ilcesi == "null" ? null : _ilcesi,
                  decoration: const InputDecoration(
                    labelText: "İlçe",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    border: OutlineInputBorder(),
                  ),
                  validator: (deger) {
                    if (deger!.isEmpty) {
                      _ilce = false;
                      return "İlçe Kısmı Boş Bırakılamaz!";
                    } else {
                      _ilce = true;
                      _ilcesi = deger;
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Colors.black,
                  initialValue: _ili == "null" ? null : _ili,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    labelText: "İl",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    border: OutlineInputBorder(),
                  ),
                  validator: (deger) {
                    if (deger!.isEmpty) {
                      _il = false;
                      return "İl Kısmı Boş Bırakılamaz!";
                    } else {
                      _il = true;
                      _ili = deger;
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Colors.black,
                  maxLines: 1,
                  initialValue:
                      _verginindairesi == "null" ? null : _verginindairesi,
                  decoration: const InputDecoration(
                    labelText: "Vergi Dairesi",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    border: OutlineInputBorder(),
                  ),
                  validator: (deger) {
                    if (deger!.isEmpty) {
                      _vergidairesi = false;
                      return "Vergi Dairesi Kısmı Boş Bırakılamaz!";
                    } else {
                      _vergidairesi = true;
                      _verginindairesi = deger;
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Colors.black,
                  initialValue: _vergininno == "null" ? null : _vergininno,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Vergi No",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    border: OutlineInputBorder(),
                  ),
                  validator: (deger) {
                    if (deger!.isEmpty) {
                      _vergino = false;
                      return "Vergi No Kısmı Boş Bırakılamaz!";
                    } else {
                      _vergino = true;
                      _vergininno = deger;
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(height: 20, color: Colors.grey),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Colors.black,
                  initialValue: _ibaninunvan == "null" ? null : _ibaninunvan,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    labelText: "İban Ünvan",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    border: OutlineInputBorder(),
                  ),
                  validator: (deger) {
                    if (deger!.isEmpty) {
                      _ibanunvan = false;
                      return "İban Ünvan Kısmı Boş Bırakılamaz!";
                    } else {
                      _ibanunvan = true;
                      _ibaninunvan = deger;
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  maxLines: 1,
                  initialValue: _ibaninno == "null" ? null : _ibaninno,
                  decoration: const InputDecoration(
                    labelText: "İban No",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    border: OutlineInputBorder(),
                  ),
                  validator: (deger) {
                    if (deger!.isEmpty) {
                      _ibanno = false;
                      return "İban No Kısmı Boş Bırakılamaz!";
                    } else {
                      _ibanno = true;
                      _ibaninno = deger;
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  initialValue:
                      _tckimliknumara == "null" ? null : _tckimliknumara,
                  cursorColor: Colors.black,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    labelText: "T.C. Kimlik No",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    border: OutlineInputBorder(),
                  ),
                  validator: (deger) {
                    if (deger!.length != 11) {
                      _tckimlikno = false;
                      return "Lütfen Geçerli Bir T.C. Kimlik Numarası Giriniz!";
                    } else if (deger.isEmpty == true) {
                      _tckimlikno = false;
                      return "T.C. Kimlik No Kısmı Boş Bırakılamaz!";
                    } else {
                      _tckimlikno = true;
                      _tckimliknumara = deger;
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CheckboxListTile(
                  value: _kampanyasecildi,
                  onChanged: (secildi) {
                    setState(() {
                      _kampanyasecildi = secildi!;
                    });
                  },
                  activeColor: Colors.amber,
                  title: const Text(
                    "Kampanyalardan haberdar olmak için elektronik ileti SMS ya da E-Posta almak istiyorum",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    if (_ad == true &&
                        _soyad == true &&
                        _firmaadi == false &&
                        _adres == false &&
                        _ilce == false &&
                        _il == false &&
                        _vergidairesi == false &&
                        _vergino == false &&
                        _ibanunvan == false &&
                        _ibanno == false &&
                        _tckimlikno == false) {
                      ToastMessageAdSoyad();
                      KullaniciIsimSoyisimBilgileriniVeritabaninaYaz();
                    } else if (_ad == true &&
                        _soyad == true &&
                        _firmaadi == true &&
                        _adres == true &&
                        _ilce == true &&
                        _il == true &&
                        _vergidairesi == true &&
                        _vergino == true &&
                        _ibanunvan == true &&
                        _ibanno == true &&
                        _tckimlikno == true) {
                      ToastMessage();
                      KullaniciBilgileriniVeritabaninaYaz();
                    } else {
                      _showMyDialog();
                    }
                  },
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "Güncelle",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 35),
        child: ClayContainer(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  "Adreslerim",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Divider(height: 20, color: Colors.black),
                Visibility(
                  visible: _adressayisi == 0 ? true : false,
                  child: Container(
                    alignment: Alignment.center,
                    height: 120,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: const Text(
                      "Henüz Ekli Adres Bulunmamaktadır.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
                Visibility(
                    visible: _adressayisi == 0 ? false : true,
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _adressayisi,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                _adressayisi % 2 == 0 ? 500 : 1000,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 170),
                        itemBuilder: (context, index) {
                          var _adresbilgi = adres[index];
                          return Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.white,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        _adresbilgi["Adres Adı"].toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      )),
                                      GestureDetector(
                                          onTap: () {
                                            _silmePopUp(
                                              _adresbilgi["Adres Adı"]
                                                  .toString(),
                                            );
                                          },
                                          child: const Icon(Icons.close)),
                                    ],
                                  ),
                                  const Divider(
                                      height: 20, color: Colors.black),
                                  Text(
                                    _adresbilgi["Adı"].toString() +
                                        " " +
                                        _adresbilgi["Soyadı"].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    _adresbilgi["Adres"].toString(),
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _adresbilgi["İlçe"].toString() +
                                        "/" +
                                        _adresbilgi["İl"].toString(),
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _adresbilgi["Telefon"].toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                          );
                        })),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/adresekle");
                  },
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "Adres Ekle",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> bilgiGetir() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final String _userId = auth.currentUser!.uid;
    var _ismiOku = await _firestore.doc("users/" + _userId).get();
    return _ismiOku;
  }

  Future<int> adresSayisiGetir() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final String _userId = auth.currentUser!.uid;
    await _firestore
        .collection("users/$_userId/Adresler")
        .get()
        .then((snapshot) => _adressayisi = snapshot.docs.length);
    return _adressayisi;
  }

  adresGetir() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final String _userId = FirebaseAuth.instance.currentUser!.uid;
    await for (var snapshot
        in _firestore.collection('users/$_userId/Adresler').snapshots()) {
      for (var message in snapshot.docs) {
        adres.add(message.data());
      }
    }
  }

  void adresSil(String _isim) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final String _userId = auth.currentUser!.uid;
    await _firestore.collection("users/$_userId/Adresler").doc(_isim).delete();
  }

  isminiGetir() async {
    DocumentSnapshot<Map<String, dynamic>> _ismiOku = await bilgiGetir();
    setState(() {
      _adsoyad = _ismiOku.data()!["Ad"].toString() +
          " " +
          _ismiOku.data()!["Soyad"].toString();
    });
  }

  ismiGetir() async {
    DocumentSnapshot<Map<String, dynamic>> _ismiOku = await bilgiGetir();
    _adi = _ismiOku.data()!["Ad"].toString();
    _soyadi = _ismiOku.data()!["Soyad"].toString();
    //_adsoyad = _ismiOku.data()!["Ad"].toString() +
    //    " " +
    //   _ismiOku.data()!["Soyad"].toString();
    _numara = _ismiOku.data()!["Telefon"].toString();
    _mail = _ismiOku.data()!["E Mail"].toString();
    _kampanyasecildi = _ismiOku.data()!["Kampanya"];
    _firmaninadi = _ismiOku.data()!["Firma Adı"].toString();
    _adresi = _ismiOku.data()!["Adres"].toString();
    _ilcesi = _ismiOku.data()!["İlçe"].toString();
    _ili = _ismiOku.data()!["İl"].toString();
    _verginindairesi = _ismiOku.data()!["Vergi Dairesi"].toString();
    _vergininno = _ismiOku.data()!["Vergi No"].toString();
    _ibaninunvan = _ismiOku.data()!["İban Unvan"].toString();
    _ibaninno = _ismiOku.data()!["İban No"].toString();
    _tckimliknumara = _ismiOku.data()!["TC Kimlik No"].toString();
    sayi++;
    // return _adsoyad;
  }

  // ignore: non_constant_identifier_names
  void KullaniciIsimSoyisimBilgileriniVeritabaninaYaz() async {
    String _userId = auth.currentUser!.uid;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    Map<String, dynamic> _eklenecekUser = <String, dynamic>{};
    _eklenecekUser["Ad"] = _adi;
    _eklenecekUser["Soyad"] = _soyadi;
    _eklenecekUser["Kampanya"] = _kampanyasecildi;
    await _firestore
        .doc("users/" + _userId)
        .set(_eklenecekUser, SetOptions(merge: true));
  }

  // ignore: non_constant_identifier_names
  void KullaniciBilgileriniVeritabaninaYaz() async {
    String _userId = auth.currentUser!.uid;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    Map<String, dynamic> _eklenecekUser = <String, dynamic>{};
    _eklenecekUser["Ad"] = _adi;
    _eklenecekUser["Soyad"] = _soyadi;
    _eklenecekUser["Firma Adı"] = _firmaninadi;
    _eklenecekUser["Firma Adresi"] = _adresi;
    _eklenecekUser["İlçe"] = _ilcesi;
    _eklenecekUser["İl"] = _ili;
    _eklenecekUser["Vergi Dairesi"] = _verginindairesi;
    _eklenecekUser["Vergi No"] = _vergininno;
    _eklenecekUser["İban Unvan"] = _ibaninunvan;
    _eklenecekUser["İban No"] = _ibaninno;
    _eklenecekUser["TC Kimlik No"] = _tckimliknumara;
    _eklenecekUser["Kampanya"] = _kampanyasecildi;
    _eklenecekUser["Kurumsal"] = true;
    await _firestore
        .doc("users/" + _userId)
        .set(_eklenecekUser, SetOptions(merge: true));
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
          EasyLoading.showSuccess('Bilgi Güncelleme Başarıyla Tamamlandı!');
        }
      });
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> ToastMessageAdSoyad() async {
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
          EasyLoading.showSuccess('Güncelleme İşlemi Başarıyla Tamamlandı!');
        }
      });
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Başarısız Kayıt Denemesi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'Lütfen tüm gereklilikleri yerine getirdiğinizden emin olun!'),
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

  Future<void> _cikis() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nereye Gidiyosun Ya?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Çıkış Yapmak İstediğinize Emin Misiniz?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Hayır',
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
              onPressed: () async {
                await auth.signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _silmePopUp(String isim) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adresi Sil'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$isim İsimli Adresi Silmek İstediğinize Emin Misiniz?'),
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
                String adresad = isim;
                adresSil(adresad);
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/anasayfa',
                    arguments: {});
              },
            ),
          ],
        );
      },
    );
  }
}
