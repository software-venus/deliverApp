import 'package:entrega/models/parameter_model.dart';
import 'package:entrega/variables/globalvar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseCustomParameterHelper {
  Future add({required BuildContext context, required String key2, required String title, required String additional, required String additionalEn}) async {
    try {
      DateTime creationTime = DateTime.now();

      final firestoreInstance = FirebaseFirestore.instance;
      CollectionReference parameter =
          firestoreInstance.collection(firebaseCustomParameterKey);
      parameter.doc().set(ParameterModel(false, "", key2, title, additional, additionalEn, creationTime).toJson());
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
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
