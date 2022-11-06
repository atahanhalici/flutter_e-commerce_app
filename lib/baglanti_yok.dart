import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// ignore: camel_case_types
class baglantiYok extends StatefulWidget {
  const baglantiYok({Key? key}) : super(key: key);

  @override
  State<baglantiYok> createState() => _baglantiYokState();
}

// ignore: camel_case_types
class _baglantiYokState extends State<baglantiYok> {
  anasayfayagit() {
    Navigator.pushReplacementNamed(context, '/anasayfa', arguments: {});
  }

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
            Timer(const Duration(seconds: 0), anasayfayagit);
            break;
          case InternetConnectionStatus.disconnected:
            break;
        }
      },
    );

    /*await Future<void>.delayed(const Duration(seconds: 30));
  await listener.cancel();*/
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(child: SizedBox()),
        Container(
          alignment: Alignment.center,
          width: 150,
          height: 150,
          child: Image.asset(
            "assets/images/nowifi.png",
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Bağlantınızda Problem Var Gibi Duruyor",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color.fromARGB(255, 0, 0, 0)),
        ),
        const Expanded(child: SizedBox()),
        Container(
          margin: const EdgeInsets.only(bottom: 25),
          alignment: Alignment.bottomCenter,
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
