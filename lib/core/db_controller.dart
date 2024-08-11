import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'model/award.dart';
import '../firebase_options.dart';

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

  Future<dynamic> getFilteredData(Map<String, dynamic> filters) async {
    Query query = _collectionRef;
    
    filters.forEach((field, value) {
      if (field == 'timestamp_to') {
        query.where(field, isLessThanOrEqualTo: value);
      } else if (field == 'timestamp_from') {
        query.where(field, isGreaterThanOrEqualTo: value);
      } else {
        query.where(field, isEqualTo: value);
      }     
    });

    QuerySnapshot querySnapshot = await query.get();

    return convertDocstoList(querySnapshot);
  }

  Future<DocumentReference> addData(Award award) {
    return _collectionRef.add(award.toFireStoreMap());
  }

}
