import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_proje_1/giris.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// ignore: camel_case_types
class sifremiunuttum extends StatefulWidget {
  const sifremiunuttum({Key? key}) : super(key: key);

  @override
  State<sifremiunuttum> createState() => _sifremiunuttumState();
}

// ignore: camel_case_types
class _sifremiunuttumState extends State<sifremiunuttum> {
  @override
  void initState() {
    asdf();
    auth = FirebaseAuth.instance;
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

  late FirebaseAuth auth;
  late String _email;
  late bool _mail;
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
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 200),
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
                      "Şifremi Unuttum",
                      textAlign: TextAlign.center,
                    )),
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
                        if (EmailValidator.validate(deger.toString()) ==
                                false &&
                            deger!.isNotEmpty) {
                          _mail = false;
                          return "Geçerli Mail Giriniz!";
                        } else if (deger!.isEmpty) {
                          _mail = false;
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
                    child: MaterialButton(
                      onPressed: () {
                        if (_mail == true) {
                          sifreSifirla();
                        } else {
                          _showMyDialog();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 180,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Şifremi Unuttum",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void sifreSifirla() async {
    try {
      await auth.sendPasswordResetEmail(email: _email);
      ToastMessage();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const giris(),
      ));
    } catch (e) {
      ToastMessageHata(e.hashCode.toString());
    }
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
          EasyLoading.showSuccess(
              'Şifre Sıfırlama Talebiniz İçin Mail Başarıyla Gönderildi.');
        }
      });
    }
  }

  // ignore: non_constant_identifier_names
  void ToastMessageHata(String hata) async {
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
          _HataliGiris(hata);
        }
      });
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> _HataliGiris(String hata) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Başarısız Şifre Yenileme Talebi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bir Hata Oluştu. Hata Kodu: $hata'),
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
}
