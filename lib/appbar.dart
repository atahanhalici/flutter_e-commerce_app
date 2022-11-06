import 'package:flutter/material.dart';

// ignore: camel_case_types
class kayanappbar extends StatefulWidget {
  const kayanappbar({Key? key}) : super(key: key);

  @override
  State<kayanappbar> createState() => _kayanappbarState();
}

// ignore: camel_case_types
class _kayanappbarState extends State<kayanappbar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      snap: true,
      expandedHeight: 70,
      backgroundColor: Colors.white,
      leading: Container(
        margin: const EdgeInsets.only(left: 10, top: 6),
        child: Image.asset(
          "assets/images/cn2.png",
        ),
      ),
      title: Container(
          height: 65,
          margin: const EdgeInsets.only(top: 12, left: 15),
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: const TextField(
            maxLines: 1,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Colors.orangeAccent),
              ),
              hintText: "Aradığınız Her Şey Burada!",
              suffixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            textInputAction: TextInputAction.search,
          )),
    );
  }
}
