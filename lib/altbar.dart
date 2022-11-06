import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AltBar extends StatefulWidget {
  final int sayi;
  final int sayim;
  const AltBar({Key? key, required this.sayi, required this.sayim})
      : super(key: key);

  @override
  State<AltBar> createState() => _AltBarState();
}

class _AltBarState extends State<AltBar> {
  int secilenmenuitem = 0;
  late FirebaseAuth auth;
  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,
              color: widget.sayi == 0
                  ? Colors.amber
                  : const Color.fromARGB(255, 116, 116, 116)),
          label: "Anasayfa",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dehaze,
              color: widget.sayi == 1
                  ? Colors.amber
                  : const Color.fromARGB(255, 116, 116, 116)),
          label: "Kategoriler",
        ),
        /* BottomNavigationBarItem(
            icon: Icon(Icons.fiber_new_rounded,
                color: widget.sayi == 1
                    ? Colors.amber
                    : const Color.fromARGB(255, 116, 116, 116)),
            label: "Yeni"),*/
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_basket,
            color: Color.fromARGB(255, 116, 116, 116),
          ),
          label: "Sepet",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite,
              color: widget.sayi == 3
                  ? Colors.amber
                  : const Color.fromARGB(255, 116, 116, 116)),
          label: "Beğenilenler",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: widget.sayi == 4
                    ? Colors.amber
                    : const Color.fromARGB(255, 116, 116, 116)),
            label: "Hesabım"),
      ],
      fixedColor: const Color.fromARGB(255, 116, 116, 116),
      type: BottomNavigationBarType.fixed,
      currentIndex: secilenmenuitem,
      selectedFontSize: 12,
      onTap: (index) {
        setState(() {
          secilenmenuitem = index;
        });
        if (secilenmenuitem == 0 && secilenmenuitem != widget.sayi) {
          if (widget.sayi == 5) {
            Navigator.pushNamed(context, "/anasayfa");
          } else {
            Navigator.pushReplacementNamed(context, '/anasayfa', arguments: {});
          }
        } else if (secilenmenuitem == 1 && secilenmenuitem != widget.sayi) {
          if (widget.sayi == 5) {
            Navigator.pushNamed(context, "/kategorilersayfasi");
          } else if (widget.sayim == 0) {
            Navigator.pushNamed(context, "/kategorilersayfasi");
          } else {
            Navigator.pushReplacementNamed(context, '/kategorilersayfasi',
                arguments: {});
          }
        } /*else if (secilenmenuitem == 1 && secilenmenuitem != widget.sayi) {
          if (widget.sayi == 5) {
            Navigator.pushNamed(context, "/yenigelenler");
          } else {
            Navigator.pushReplacementNamed(context, '/yenigelenler',
                arguments: {});
          }
        } */
        else if (secilenmenuitem == 2 && secilenmenuitem != widget.sayi) {
          if (auth.currentUser == null) {
            if (widget.sayi == 5) {
              Navigator.pushNamed(context, "/sepet");
            } else if (widget.sayim == 0) {
              Navigator.pushNamed(context, "/sepet");
            } else {
              Navigator.pushNamed(context, "/sepet");
              // Navigator.pushReplacementNamed(context, '/sepet', arguments: {});
            }
          } else {
            if (widget.sayi == 5) {
              Navigator.pushNamed(context, "/sepetoturum");
            } else if (widget.sayim == 0) {
              Navigator.pushNamed(context, "/sepetoturum");
            } else {
              Navigator.pushNamed(context, "/sepetoturum");
              /* Navigator.pushReplacementNamed(context, '/sepetoturum',
                  arguments: {});*/
            }
          }
        } else if (secilenmenuitem == 3 && secilenmenuitem != widget.sayi) {
          if (widget.sayi == 5) {
            Navigator.pushNamed(context, "/begeni");
          } else if (widget.sayim == 0) {
            Navigator.pushNamed(context, "/begeni");
          } else {
            Navigator.pushReplacementNamed(context, '/begeni', arguments: {});
          }
        } else if (secilenmenuitem == 4 && secilenmenuitem != widget.sayi) {
          if (auth.currentUser == null) {
            if (widget.sayi == 5) {
              Navigator.pushNamed(context, "/giris");
            } else if (widget.sayim == 0) {
              Navigator.pushNamed(context, "/giris");
            } else {
              Navigator.pushReplacementNamed(context, '/giris', arguments: {});
            }
          } else {
            if (widget.sayi == 5) {
              Navigator.pushNamed(context, "/profil");
            } else if (widget.sayim == 0) {
              Navigator.pushNamed(context, "/profil");
            } else {
              Navigator.pushReplacementNamed(context, '/profil', arguments: {});
            }
          }
        }
      },
    );
  }
}
