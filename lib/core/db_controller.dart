import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './model/award.dart';
import '../firebase_options.dart';

class AwardDbController extends ChangeNotifier {

  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('Searched_users');

  Future<dynamic> getData() async {
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await _collectionRef.get();

      // Get data from docs and convert map to List
      final data = querySnapshot.docs.map((doc) => doc.data()).toList();

      return data;
  }

  Future<DocumentReference> addData(Award award) {
    return _collectionRef
        .add(<String, dynamic>{
      'Nome': award.name,
      'Link': award.url,
      'Olimpíada': award.olympiad,
      'Cidade/Estado': award.city_state,
      'Medalha': award.medal,
      'Pontuação': award.score,
      'Escola': award.school,
      'TimeStamp': DateTime.now().millisecondsSinceEpoch,
    });
  }
}