import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_proje_1/baglanti_kontrol.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// ignore: camel_case_types
class welcomeScreen extends StatefulWidget {
  const welcomeScreen({Key? key}) : super(key: key);

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

// ignore: camel_case_types
class _welcomeScreenState extends State<welcomeScreen> {
  /*late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;*/
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
    final StreamSubscription<InternetConnectionStatus> listener =
        InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            Timer(const Duration(seconds: 1), anasayfayagit);
            break;
          case InternetConnectionStatus.disconnected:
            Timer(const Duration(seconds: 1), nowifi);

            break;
        }
      },
    );

    await Future<void>.delayed(const Duration(seconds: 30));
    await listener.cancel();
  }

  /*getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          Navigator.pushReplacementNamed(context, '/baglantiyok',
              arguments: {});
          isAlertSet = true;
        } else {
          Timer(const Duration(seconds: 1), anasayfayagit);
        }
      });*/
  anasayfayagit() {
    Navigator.pushReplacementNamed(context, '/anasayfa', arguments: {});
  }

  nowifi() {
    Navigator.pushReplacementNamed(context, '/baglantiyok', arguments: {});
  }

/*
  @override
  void dispose() {
    getConnectivity();
    super.dispose();
  }
*/
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            width: 150,
            height: 150,
            child: Image.asset(
              "assets/images/cn2.png",
            ),
          ),
        ),
        const baglantiKontrol(),
        Container(
          margin: const EdgeInsets.only(bottom: 25), //Alignment.bottomCenter,
          child: const Text(
            "carsinette.com",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(140, 0, 0, 0)),
          ),
        ),
      ],
    ));
  }
}
