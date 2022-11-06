import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_proje_1/anasayfa.dart';
import 'package:flutter_pw_validator/Resource/Strings.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// ignore: must_be_immutable
class Kayit extends StatefulWidget {
  const Kayit({Key? key}) : super(key: key);

  @override
  State<Kayit> createState() => _KayitState();
}

class FrenchStrings implements FlutterPwValidatorStrings {
  @override
  final String atLeast = 'En az - karakter';

  @override
  final String uppercaseLetters = 'En az - büyük harf';
  @override
  final String numericCharacters = 'En az - rakam';
  @override
  final String specialCharacters = '- Caractères spéciaux';
  @override
  final String normalLetters = '- Caractères spéciaux';
}

class _KayitState extends State<Kayit> {
  @override
  void initState() {
    asdf();
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

  final TextEditingController controller = TextEditingController();
  late String _email;
  late String _password;
  bool _kurumsal = false;
  bool _gizli = true;
  bool _kampanyasecildi = false;
  bool _sozlesmesecildi = false;
  late String _name;
  late String _surname;
  late String _phonenumber;
  bool _ad = false;
  bool _soyad = false;
  bool _telefon = false;
  bool _mail = false;
  bool _sifre = false;
  Timer? _timer;
  late double _progress;

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
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(left: 35),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 226, 226, 226),
                            border: Border(
                              top: BorderSide(width: 1.0, color: Colors.black),
                            ),
                          ),
                          height: 50,
                          child: const Center(
                              child: Text(
                            "Giriş Yap",
                            textAlign: TextAlign.center,
                          )),
                        ),
                        onTap: () {
                          setState(() {
                            Navigator.pushReplacementNamed(context, '/giris',
                                arguments: {});
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(right: 35),
                          height: 50,
                          child: const Center(
                              child: Text(
                            "Kayıt Ol",
                            textAlign: TextAlign.center,
                          )),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 1.0, color: Colors.amber),
                            ),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
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
                        return "Ad Kısmı Boş Bırakılamaz!";
                      } else {
                        _ad = true;
                        _name = deger;
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
                        return "Soyad Kısmı Boş Bırakılamaz!";
                      } else {
                        _soyad = true;
                        _surname = deger;
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
                        return "Telefon Kısmı Boş Bırakılamaz!";
                      } else {
                        _telefon = true;
                        _phonenumber = deger;
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
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      labelText: "E-Mail",
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      border: OutlineInputBorder(),
                      hintText: "E-mail",
                    ),
                    validator: (deger) {
                      if (EmailValidator.validate(deger.toString()) == false &&
                          deger!.isNotEmpty) {
                        return "Geçerli Mail Giriniz!";
                      } else if (deger!.isEmpty) {
                        return "E-Mail Kısmı Boş Bırakılamaz";
                      } else {
                        _mail = true;
                        _email = deger;
                      }
                      return null;
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
                    controller: controller,
                    cursorColor: Colors.black,
                    obscureText: _gizli,
                    maxLines: 1,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _gizli = !_gizli;
                            });
                          },
                          icon: _gizli
                              ? const Icon(Icons.visibility, color: Colors.grey)
                              : const Icon(Icons.visibility_off,
                                  color: Colors.grey)),
                      labelText: "Şifre",
                      labelStyle: const TextStyle(color: Colors.black),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber)),
                      border: const OutlineInputBorder(),
                      hintText: "Şifre",
                    ),
                    validator: (deger) {
                      if (deger!.isEmpty ||
                          deger.isNotEmpty && _sifre == false) {
                        return "Lütfen Tüm Şartları Sağlayınız!";
                      } else {
                        _password = deger;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  child: FlutterPwValidator(
                      controller: controller,
                      minLength: 6,
                      numericCharCount: 2,
                      uppercaseCharCount: 1,
                      width: 350,
                      height: 70,
                      defaultColor: const Color.fromARGB(136, 19, 19, 19),
                      successColor: Colors.lightGreen,
                      failureColor: Colors.red,
                      strings: FrenchStrings(),
                      onSuccess: () {
                        setState(() {
                          _sifre = true;
                        });
                      },
                      onFail: () {
                        setState(() {
                          _sifre = false;
                        });
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                  child: Text("Hesap Türü:"),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: _kurumsal == true
                                  ? const Color.fromARGB(255, 224, 224, 224)
                                  : const Color.fromARGB(136, 19, 19, 19),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: Center(
                                child: Text(
                              "Bireysel",
                              style: TextStyle(
                                  color: _kurumsal == false
                                      ? Colors.white
                                      : Colors.black),
                            )),
                          ),
                          onTap: () {
                            setState(() {
                              _kurumsal = false;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: _kurumsal == false
                                  ? const Color.fromARGB(255, 224, 224, 224)
                                  : const Color.fromARGB(136, 19, 19, 19),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: Center(
                                child: Text(
                              "Kurumsal",
                              style: TextStyle(
                                  color: _kurumsal == true
                                      ? Colors.white
                                      : Colors.black),
                            )),
                          ),
                          onTap: () {
                            setState(() {
                              _kurumsal = true;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: _kurumsal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 207, 226, 255),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Kurumsal Hesaplar Onaya Tabidir.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 8, 66, 152),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          height: 2,
                          color: Color.fromARGB(255, 8, 66, 152),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // ignore: avoid_unnecessary_containers
                        Container(
                          child: const Text(
                            "Onaylı kurumsal hesaplar toptan satış fiyatları üzerinden alışveriş yapabilmektedir. Kurumsal hesabınızın aktif olabilmesi için şirket bilgilerinizin tam olarak girilmiş olması gerekmektedir.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 8, 66, 152),
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CheckboxListTile(
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
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CheckboxListTile(
                    value: _sozlesmesecildi,
                    onChanged: (secildi) {
                      setState(() {
                        _sozlesmesecildi = secildi!;
                      });
                    },
                    activeColor: Colors.amber,
                    title: const Text(
                      "Üyelik koşullarını ve kişisel verilerimin korunmasını kabul ediyorum",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 224, 224, 224),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "Üyelik koşullarını ve kişisel verilerin korunması ilkelerini kabul etmediğiniz takdirde kayıt olabilmeniz mümkün değildir.",
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  child: MaterialButton(
                    onPressed: () {
                      if (_ad == true &&
                          _soyad == true &&
                          _mail == true &&
                          _telefon == true &&
                          _sifre == true &&
                          _sozlesmesecildi == true) {
                        KullaniciOlustur();
                      } else {
                        _showMyDialog();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Kayıt Ol",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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

  // ignore: non_constant_identifier_names
  Future<void> _HataliGiris() async {
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
                    'Bu mail adresi ile daha önce sisteme kayıt yapılmış. Lütfen giriş yapınız.'),
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
  void KullaniciOlustur() async {
    try {
      // ignore: unused_local_variable
      await ToastMessage();
      // ignore: unused_local_variable
      var _kullaniciolusturma = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const anasayfa(),
      ));
      KullaniciBilgileriniVeritabaninaYaz();
    } catch (e) {
      ToastMessageHata();
    }
  }

  deneme() async {
    String _userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var boxs = Hive.box("SepettekiUrunler");
    var box = Hive.box("BegenilenUrunler");
    if (boxs.isNotEmpty) {
      for (var message in boxs.values) {
        Map<String, dynamic> urun = {
          "Adı": message["Adı"],
          "Fiyat": message["Fiyat"],
          "Beden": message["Beden"],
          "Adet": message["Adet"]
        };
        try {
          await _firestore
              .collection("users/$_userId/SepettekiUrunler")
              .doc(message["Adı"] + " " + message["Beden"] + " Beden")
              .set(urun, SetOptions(merge: true));
          boxs.delete(message["Adı"] + " " + message["Beden"] + " Beden");
        }
        // ignore: empty_catches
        catch (e) {}
      }
      if (box.isNotEmpty) {
        for (var message in box.values) {
          Map<String, dynamic> urun = {
            "Adı": message["Adı"],
            "Fiyat": message["Fiyat"],
          };
          try {
            await _firestore
                .collection("users/$_userId/BegenilenUrunler")
                .doc(message["Adı"])
                .set(urun, SetOptions(merge: true));
            box.delete(message["Adı"]);
          }
          // ignore: empty_catches
          catch (e) {}
        }
      }
    }
  }

  // ignore: non_constant_identifier_names
  void KullaniciBilgileriniVeritabaninaYaz() async {
    String _userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    Map<String, dynamic> _eklenecekUser = <String, dynamic>{};
    _eklenecekUser["Ad"] = _name;
    _eklenecekUser["Soyad"] = _surname;
    _eklenecekUser["Telefon"] = _phonenumber;
    _eklenecekUser["E Mail"] = _email;
    _eklenecekUser["Kampanya"] = _kampanyasecildi;
    _eklenecekUser["Kurumsal"] = false;
    await _firestore.doc("users/" + _userId).set(_eklenecekUser);
    deneme();
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
          EasyLoading.showSuccess('Kayıt İşlemi Başarıyla Tamamlandı!');
        }
      });
    }
  }

  // ignore: non_constant_identifier_names
  void ToastMessageHata() async {
    {
      _progress = 0;
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
        EasyLoading.showProgress(_progress,
            status: '${(_progress * 100).toStringAsFixed(0)}%');
        _progress += 0.3;
        EasyLoadingMaskType.black;
        if (_progress >= 1) {
          _timer?.cancel();
          EasyLoading.dismiss();
          _HataliGiris();
        }
      });
    }
  }
}
