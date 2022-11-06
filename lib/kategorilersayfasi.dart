import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_proje_1/altbar.dart';
import 'package:flutter_proje_1/altmenu.dart';
import 'package:flutter_proje_1/kategoriler.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'appbar.dart';

class KategorilerSayfasi extends StatefulWidget {
  const KategorilerSayfasi({Key? key}) : super(key: key);

  @override
  State<KategorilerSayfasi> createState() => _KategorilerSayfasiState();
}

class _KategorilerSayfasiState extends State<KategorilerSayfasi> {
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
        sayi: 1, sayim:1
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
                      const Text(
                        "Alışveriş Kadın Giyim Aksesuar Uygun Fiyat Fırsat Ucuz Çarşı Nette",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        "Alışveriş Kadın Aksesuar ve Daha Fazlası",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Kategoriler(),
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
