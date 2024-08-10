import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './model/award.dart';
import '../firebase_options.dart';

class AwardDbController extends ChangeNotifier {

  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('Searched_users');

  List<dynamic> convertDocstoList(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) =>
    Award.fromFirestore(doc))
    .toList();

  }

  Future<dynamic> getData(
    
  ) async {
      // Get docs from collection reference
      QuerySnapshot querySnapshot = 
        await _collectionRef
        .get();

      // Get data from docs and convert map to List
      final data = convertDocstoList(querySnapshot);

      return data;
  }

  Future<dynamic> getFilteredData(Map<String, dynamic> filters) async {
    Query query = _collectionRef;
    
    filters.forEach((field, value) {
      if (field == 'timestamp_to') {
        query.where(field, isLessThanOrEqualTo: value);
      }
      if (field == 'timestamp_from') {
        query.where(field, isGreaterThanOrEqualTo: value);
      }
      query.where(field, isEqualTo: value);
    });

    QuerySnapshot querySnapshot = await query.get();

    final data = convertDocstoList(querySnapshot);

    return data;
  }

  Future<DocumentReference> addData(Award award) {
    return _collectionRef
        .add(award.toFireStoreMap());
  }
}