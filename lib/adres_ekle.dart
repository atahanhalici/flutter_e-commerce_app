import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AdresEkle extends StatefulWidget {
  const AdresEkle({Key? key}) : super(key: key);

  @override
  State<AdresEkle> createState() => _AdresEkleState();
}

class _AdresEkleState extends State<AdresEkle> {
  // ignore: unused_field
  int _toplamadres = 0;
  String? _ad;
  String? _soyad;
  String? _telefon;
  String? _adresAdi;
  String? _adres;
  String? _il;
  String? _ilce;
  bool _adi = false;
  bool _soyadi = false;
  bool _telefonu = false;
  bool _adresinAdi = false;
  bool _adresi = false;
  bool _ili = false;
  bool _ilcesi = false;
  late FirebaseAuth auth;
  Timer? _timer;
  late double _progress;
  @override
  void initState() {
    super.initState();
    asdf();
    auth = FirebaseAuth.instance;
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

  Map<String, dynamic> adresBilgi = {};
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
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 40),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.amber),
                      ),
                    ),
                    height: 50,
                    child: const Center(
                        child: Text(
                      "Adres Ekle",
                      textAlign: TextAlign.center,
                    )),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: Colors.black,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        labelText: "Adınız",
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(),
                        hintText: "Adınız",
                      ),
                      validator: (deger) {
                        if (deger!.isEmpty) {
                          _adi = false;
                          return "Ad Kısmı Boş Bırakılamaz!";
                        } else {
                          _adi = true;
                          _ad = deger;
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: Colors.black,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        labelText: "Soyadınız",
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(),
                        hintText: "Soyadınız",
                      ),
                      validator: (deger) {
                        if (deger!.isEmpty) {
                          _soyadi = false;
                          return "Soyad Kısmı Boş Bırakılamaz!";
                        } else {
                          _soyadi = true;
                          _soyad = deger;
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: Colors.black,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        labelText: "Cep Telefonu",
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(),
                        hintText: "0(555) 555 55 55",
                      ),
                      validator: (deger) {
                        if (deger!.isEmpty) {
                          _telefonu = false;
                          return "Telefon Kısmı Boş Bırakılamaz!";
                        } else {
                          _telefonu = true;
                          _telefon = deger;
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: Colors.black,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        labelText: "Adres Adı",
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(),
                        hintText: "Adres Adı",
                      ),
                      validator: (deger) {
                        if (deger!.isEmpty) {
                          _adresinAdi = false;
                          return "Adres Adı Kısmı Boş Bırakılamaz!";
                        } else {
                          _adresinAdi = true;
                          _adresAdi = deger;
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: Colors.black,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: "Adres",
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(),
                        hintText: "Adres",
                      ),
                      validator: (deger) {
                        if (deger!.isEmpty) {
                          _adresi = false;
                          return "Adres Kısmı Boş Bırakılamaz!";
                        } else {
                          _adresi = true;
                          _adres = deger;
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
                        margin: const EdgeInsets.symmetric(horizontal: 10),
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
                                  (String oAnkiSehir) => DropdownMenuItem(
                                    child: Text(oAnkiSehir),
                                    value: oAnkiSehir,
                                  ),
                                )
                                .toList(),
                            value: _secilenSehir,
                            onChanged: (String? yeni) {
                              if (yeni!.isEmpty) {
                                _ili = false;
                              } else {
                                setState(() {
                                  _secilenSehir = yeni;
                                  _il = yeni;
                                  _ili = true;
                                });
                              }
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: Colors.black,
                      maxLines: 1,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        labelText: "İlçe",
                        labelStyle: const TextStyle(color: Colors.black),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber)),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        border: const OutlineInputBorder(),
                        hintText: "İlçe",
                      ),
                      validator: (deger) {
                        if (deger!.isEmpty) {
                          _ilcesi = false;
                          return "İlçe Kısmı Boş Bırakılamaz!";
                        } else {
                          _ilcesi = true;
                          _ilce = deger;
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (_adi == true &&
                          _soyadi == true &&
                          _adresi == true &&
                          _telefonu == true &&
                          _ili == true &&
                          _adresinAdi == true &&
                          _ilcesi == true) {
                        AdresEkle();
                        ToastMessage();
                        setState(() {
                          Navigator.pushReplacementNamed(context, '/profil',
                              arguments: {});
                        });
                      } else {
                        _showMyDialog();
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        "Adres Ekle",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Başarısız Adres Kayıt Denemesi'),
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

  // ignore: non_constant_identifier_names
  void AdresEkle() async {
    String _userId = auth.currentUser!.uid;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    Map<String, dynamic> _eklenecekUser = <String, dynamic>{};
    await _firestore
        .collection("users/$_userId/Adresler")
        .get()
        .then((snapshot) => _toplamadres = snapshot.docs.length);

    _eklenecekUser["Adı"] = _ad;
    _eklenecekUser["Soyadı"] = _soyad;
    _eklenecekUser["Telefon"] = _telefon;
    _eklenecekUser["İl"] = _il;
    _eklenecekUser["İlçe"] = _ilce;
    _eklenecekUser["Adres"] = _adres;
    _eklenecekUser["Adres Adı"] = _adresAdi;
    await _firestore
        .collection("users/$_userId/Adresler")
        .doc(_adresAdi)
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
          EasyLoading.showSuccess('Adres Ekleme İşlemi Başarıyla Tamamlandı!');
        }
      });
    }
  }
}
