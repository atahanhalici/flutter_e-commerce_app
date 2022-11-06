import 'package:flutter/material.dart';

// ignore: camel_case_types
class altmenu extends StatefulWidget {
  const altmenu({Key? key}) : super(key: key);

  @override
  State<altmenu> createState() => _altmenuState();
}

// ignore: camel_case_types
class _altmenuState extends State<altmenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      decoration: const BoxDecoration(color: Color.fromARGB(221, 65, 65, 65)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/cn2.png",
              height: 80,
              width: 80,
            ),
            const Text(
              "carsinette.com",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25),
            ),
            const Text(
              "Alışveriş En Kaliteli Markalar Kadın Giyim Erkek Giyim Aksesuar ve dahası Çarşı Nette",
              style: TextStyle(color: Colors.white, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.white,
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Türkçe",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white)),
                  onPressed: () {},
                  child: const Text(
                    "English",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
