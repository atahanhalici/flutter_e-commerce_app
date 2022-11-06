// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_proje_1/anasayfa.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class giris extends StatefulWidget {
  const giris({Key? key}) : super(key: key);

  @override
  State<giris> createState() => _girisState();
}

class _girisState extends State<giris> {
  @override
  void initState() {
    auth = FirebaseAuth.instance;
    super.initState();
    asdf();
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

  late String _email;
  late String _password;
  bool _gizli = true;
  bool _mail = false;
  bool _sifre = false;
  late FirebaseAuth auth;
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
        ..maskColor = Colors.blue.withOpacity(0.5)
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
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 100),
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
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 1.0, color: Colors.amber),
                            ),
                          ),
                          height: 50,
                          child: const Center(
                              child: Text(
                            "Giriş Yap",
                            textAlign: TextAlign.center,
                          )),
                        ),
                        onTap: () {},
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
                            color: Color.fromARGB(255, 226, 226, 226),
                            border: Border(
                              top: BorderSide(width: 1.0, color: Colors.black),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            Navigator.pushReplacementNamed(context, '/kayit',
                                arguments: {});
                          });
                        },
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
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      border: const OutlineInputBorder(),
                      hintText: "Şifre",
                    ),
                    validator: (deger) {
                      if (deger!.isEmpty) {
                        return "Şifre Kısmı Boş Bırakılamaz!";
                      } else {
                        _sifre = true;
                        _password = deger;
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
                  child: MaterialButton(
                    onPressed: () {
                      if (_mail == true && _sifre == true) {
                        GirisYap();
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
                        "Giriş Yap",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                    child: const Text("Şifremi Unuttum"),
                    onPressed: () {
                      Navigator.pushNamed(context, "/sifremiunuttum");
                    }),
                MaterialButton(
                    child: const Text("Hesabın yok mu? Hemen Üye Ol"),
                    onPressed: () {
                      Navigator.pushNamed(context, "/kayit");
                    }),
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
          title: const Text('Başarısız Giriş Denemesi'),
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
          title: const Text('Başarısız Giriş Denemesi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Hatalı Mail veya Şifre! Lütfen Kontrol edin.'),
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
  void GirisYap() async {
    try {
      // ignore: unused_local_variable
      var _girisyapma = await auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      await ToastMessage();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const anasayfa(),
      ));
    } catch (e) {
      await ToastMessageHata();
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> ToastMessage() async {
    {
      _progress = 0;
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(milliseconds: 100),
          (Timer timer) async {
        EasyLoading.showProgress(_progress,
            status: '${(_progress * 100).toStringAsFixed(0)}%');
        _progress += 0.3;
        if (_progress >= 1) {
          _timer?.cancel();
          await EasyLoading.showSuccess('Giriş İşlemi Başarıyla Tamamlandı!');
        }
      });
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> ToastMessageHata() async {
    {
      _progress = 0;
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(milliseconds: 100),
          (Timer timer) async {
        EasyLoading.showProgress(_progress,
            status: '${(_progress * 100).toStringAsFixed(0)}%');
        _progress += 0.3;
        if (_progress >= 1) {
          _timer?.cancel();
          await EasyLoading.dismiss();
          _HataliGiris();
        }
      });
    }
  }
}
