import 'package:flutter/material.dart';

class UstBar extends StatefulWidget {
  const UstBar({Key? key}) : super(key: key);

  @override
  State<UstBar> createState() => _UstBarState();
}

class _UstBarState extends State<UstBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10,left: 15),
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: const TextField(
          maxLines: 1,
          decoration:  InputDecoration(
            focusedBorder:  OutlineInputBorder(
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
        ));
  }
}
