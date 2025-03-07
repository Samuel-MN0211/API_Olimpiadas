import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';
import 'model/award.dart';

class AwardDbController extends ChangeNotifier {

  CollectionReference _collectionRef = 
    FirebaseFirestore.instance.collection('Searched_users');

  AwardDbController() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }  

  List<dynamic> convertDocstoList(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) =>
    Award.fromFirestore(doc))
    .toList();
  }

  Future<dynamic> getData() async {
      QuerySnapshot querySnapshot = await _collectionRef.get();
      return convertDocstoList(querySnapshot);
  }

  Future<List<dynamic>> getFilteredData(Map<String, dynamic> filters, {int? limit}) async {
    Query query = _collectionRef;

    filters.forEach((field, value) {
      if (value != null) {
        if (field == 'timestamp_to') {
          query = query.where('TimeStamp', isLessThanOrEqualTo: value);
        } else if (field == 'timestamp_from') {
          query = query.where('TimeStamp', isGreaterThanOrEqualTo: value);
        } else {
          query = query.where(field, isEqualTo: value);
        }
      }
    });

    query = query.orderBy('TimeStamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    QuerySnapshot querySnapshot = await query.get();

    return convertDocstoList(querySnapshot);
  }

Future<DocumentReference?> addData(Award award) async {
    Map<String, dynamic> awardMap = award.toFireStoreMap();
    Map<String, dynamic> filteredMap = Map.fromEntries(
      awardMap.entries.where((entry) => 
        ['Nome', 'Olimpíada', 'Ano', 'Medalha'].contains(entry.key))
    );
    List<dynamic> previousAwards = await getFilteredData(filteredMap);

    if (previousAwards.length == 0) {
      return _collectionRef.add(award.toFireStoreMap());
    } else {
      return null;
    }
  }

}
