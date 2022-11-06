import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proje_1/adres_ekle.dart';
import 'package:flutter_proje_1/anasayfa.dart';
import 'package:flutter_proje_1/baglanti_yok.dart';
import 'package:flutter_proje_1/giris.dart';
import 'package:flutter_proje_1/indirimsayfasi.dart';
import 'package:flutter_proje_1/kategorilersayfasi.dart';
import 'package:flutter_proje_1/kayit.dart';
import 'package:flutter_proje_1/main.dart';
import 'package:flutter_proje_1/profilsayfasi.dart';
import 'package:flutter_proje_1/sepetacikoturum.dart';
import 'package:flutter_proje_1/sepetsayfasi.dart';
import 'package:flutter_proje_1/sifremiunuttum.dart';
import 'package:flutter_proje_1/yenigelenler.dart';

class RouteGenerator {
  static Route<dynamic>? _gidilecekrota(Widget gidilecekWidget) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(builder: (context) => gidilecekWidget);
    } else {
      return MaterialPageRoute(builder: (context) => gidilecekWidget);
    }
  }

  static Route<dynamic>? rotaOlustur(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _gidilecekrota( MyHomePage());
      case '/anasayfa':
        return _gidilecekrota(const anasayfa());
      case '/giris':
        return _gidilecekrota(const giris());
      case '/kayit':
        return _gidilecekrota(const Kayit());
      case "/kategorilersayfasi":
        return _gidilecekrota(const KategorilerSayfasi());
      case "/yenigelenler":
        return _gidilecekrota(const yenigelenler());
      case "/sepet":
        return _gidilecekrota(const SepetSayfasi());
      case "/begeni":
        return _gidilecekrota(const begeniSayfasi());
      case "/sifremiunuttum":
        return _gidilecekrota(const sifremiunuttum());
      case "/profil":
        return _gidilecekrota(const ProfilSayfasi());
      case "/adresekle":
        return _gidilecekrota(const AdresEkle());
      case "/baglantiyok":
        return _gidilecekrota(const baglantiYok());
      case "/sepetoturum":
        return _gidilecekrota(const SepetAcikOturum());
      default:
        return _gidilecekrota(const anasayfa());
    }
  }
}
