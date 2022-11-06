import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final String _userId = auth.currentUser!.uid;

Widget showName(int sayi) => FutureBuilder<DocumentSnapshot>(
      future: _firestore.doc("users/" + _userId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (sayi == 1) {
          if (snapshot.hasError) {
            return const Text("Bir şeyler ters gitti gibi...",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("İsim Bulunamadı",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text(
              "${data['Ad']} ${data['Soyad']}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            );
          }
        }

        return const Text("",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      },
    );
