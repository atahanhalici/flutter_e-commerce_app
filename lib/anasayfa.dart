import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_proje_1/slider_menu.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'altbar.dart';
import 'altmenu.dart';
import 'appbar.dart';
import 'blog.dart';
import 'dikkatcekenurunler.dart';
import 'kategoriler.dart';

// ignore: camel_case_types
class anasayfa extends StatefulWidget {
  const anasayfa({Key? key}) : super(key: key);

  @override
  State<anasayfa> createState() => _anasayfaState();
}

// ignore: camel_case_types
class _anasayfaState extends State<anasayfa> {
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
      bottomNavigationBar: const AltBar(sayi: 0, sayim: 0),
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
                      const SliderMenu(),
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
                      const Text(
                        "Dikkat Çeken Ürünler",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        "Bugün En Çok İncelenen Ürünler",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const onecikanurunler(),
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
                      const Text(
                        "Blog",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        "Güncel Kampanyalar İndirim Kuponları ve Daha Bir Çok Fırsat",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const blog(),
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
