// import 'dart:convert';
// import 'dart:ffi';

import 'package:entrega/models/parameter_model.dart';
import 'package:entrega/variables/globalvar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseTracksHelper {
  Future<String?> add(var trackData) async {
    try {
      final firestoreInstance = FirebaseFirestore.instance;
      final CollectionReference tracks = firestoreInstance.collection(firebaseTracksKey);

      final String trackingNumber = trackData['trackingNumber'];

      // Check if trackingNumber already exists
      final existing = await tracks
          .where('trackingNumber', isEqualTo: trackingNumber)
          .where("username", isEqualTo: trackData['username'])
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) {
        return 'Track ID already exists';
      }

      // Add new document with createdAt timestamp
      trackData['createdAt'] = DateTime.now();
      await tracks.doc().set(trackData);

      return null; // success
    } catch (e) {
      return e.toString(); // fallback for other errors
    }
  }


  Future modify(
      {required BuildContext context, required ParameterModel parameterModel}) async {
    try {
      final firestoreInstance = FirebaseFirestore.instance;
      firestoreInstance
          .collection(firebaseCustomParameterKey)
          .doc(parameterModel.key)
          .update(parameterModel.toJson());

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future delete(
      {required BuildContext context, required ParameterModel parameterModel}) async {
    try {
      final firestoreInstance = FirebaseFirestore.instance;
      firestoreInstance
          .collection(firebaseCustomParameterKey)
          .doc(parameterModel.key)
          .delete();

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
