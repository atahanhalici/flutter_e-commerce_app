import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_proje_1/altbar.dart';
import 'package:flutter_proje_1/altmenu.dart';
import 'package:flutter_proje_1/dikkatcekenurunler.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'appbar.dart';

// ignore: camel_case_types
class yenigelenler extends StatefulWidget {
  const yenigelenler({Key? key}) : super(key: key);

  @override
  State<yenigelenler> createState() => _yenigelenlerState();
}

// ignore: camel_case_types
class _yenigelenlerState extends State<yenigelenler> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AltBar(
        sayi: 1,sayim:1
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
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Yeni Gelenler",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const onecikanurunler(),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 25,
                        width: 180,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 25,
                              width: 110,
                              padding: const EdgeInsets.only(top: 3),
                              child: const Text(
                                "1 / 248 Sayfa",
                                style: TextStyle(color: Colors.amber),
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1)),
                            ),
                            GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.only(top: 3),
                                height: 25,
                                width: 70,
                                child: const Text(
                                  "İleri",
                                  style: TextStyle(color: Colors.amber),
                                  textAlign: TextAlign.center,
                                ),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.grey, width: 1),
                                        right: BorderSide(
                                            color: Colors.grey, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.grey, width: 1))),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
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
              )
            ]))
          ],
        ),
      ),
    );
  }
}
