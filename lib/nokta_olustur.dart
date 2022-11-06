import 'package:flutter/material.dart';

// ignore: camel_case_types
class noktaOlustur extends StatefulWidget {
  final int sayi;
  const noktaOlustur({Key? key, required this.sayi}) : super(key: key);

  @override
  State<noktaOlustur> createState() => _noktaOlusturState();
}

// ignore: camel_case_types
class _noktaOlusturState extends State<noktaOlustur>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation2;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.sayi));
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    animation2 = AlignmentTween(
            begin: const Alignment(0, 0), end: const Alignment(0, -1))
        .animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      alignment: animation2.value,
      // ignore: prefer_const_constructors
      child: Text(
        ".",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }
}
