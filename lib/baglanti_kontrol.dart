import 'package:flutter/material.dart';
import 'package:flutter_proje_1/nokta_olustur.dart';

// ignore: camel_case_types
class baglantiKontrol extends StatefulWidget {
  const baglantiKontrol({Key? key}) : super(key: key);

  @override
  State<baglantiKontrol> createState() => _baglantiKontrolState();
}

// ignore: camel_case_types
class _baglantiKontrolState extends State<baglantiKontrol> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: const Text(
              "Bağlantı Kontrol Ediliyor",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Container(
              height: 10,
              alignment: Alignment.bottomCenter,
              child: const SizedBox(
                width: 3,
              )),
          const noktaOlustur(sayi: 1500),
          const noktaOlustur(sayi: 750),
          const noktaOlustur(sayi: 1500),
        ],
      ),
    );
  }
}
