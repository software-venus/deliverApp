import 'dart:math';

import 'package:entrega/models/answer_model.dart';
import 'package:entrega/models/category_model.dart';
import 'package:entrega/models/question_answer_model.dart';
import 'package:entrega/models/question_model.dart';
import 'package:entrega/models/user_exam_model.dart';
import 'package:entrega/utils/general/show_dialog_wait.dart';
import 'package:entrega/variables/globalvar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseCustomUserExamHelper {
  Future add({
    required BuildContext context,
    required UserExamModel userExamModel,
  }) async {
    ShowDialogWait showDialogWait = ShowDialogWait();
    showDialogWait.show(context, userExamABMSaving);

    try {
      final firestoreInstance = FirebaseFirestore.instance;
      CollectionReference userExams =
          firestoreInstance.collection(firebaseCustomUserExamKey);

      CollectionReference questions =
          firestoreInstance.collection(firebaseCustomQuestionKey);
/*
      List<String> ids = [];
      List<String> newIds = generateCategorysIds(userExamModel.categorys);

      do {
        String newId = newIds[_getRandomInt(0, newIds.length - 1)];

        if (!ids.contains(newId)) {
          ids.add(newId);
        }
      } while (ids.length < userExamModel.maxQuestions);

      for (String id in ids) {
        DocumentSnapshot questionDocumentSnapshot =
            await questions.doc(id).get();

        if (questionDocumentSnapshot.exists) {
          QuestionModel questionModel = QuestionModel.fromJSON(false,
              questionDocumentSnapshot.id, questionDocumentSnapshot.data());

          QuestionAnswerModel newQuestionAnswer =
              QuestionAnswerModel(questionModel, AnswerModel("", false));

          userExamModel.questionAnswers.add(newQuestionAnswer);
        }
      }
*/

      List<String> resultIds = [];
      List<String> newIds = generateCategorysIds(userExamModel.categorys);

      do {
        String newId = newIds[_getRandomInt(0, newIds.length - 1)];

        if (!resultIds.contains(newId)) {
          DocumentSnapshot questionDocumentSnapshot =
              await questions.doc(newId).get();

          if (questionDocumentSnapshot.exists) {
            QuestionModel questionModel = QuestionModel.fromJSON(false,
                questionDocumentSnapshot.id, questionDocumentSnapshot.data());

            QuestionAnswerModel newQuestionAnswer =
                QuestionAnswerModel(questionModel, AnswerModel("", false));

            userExamModel.questionAnswers.add(newQuestionAnswer);

            resultIds.add(newId);
          }
        }
      } while (
          userExamModel.questionAnswers.length < userExamModel.maxQuestions);

      await userExams
          .doc(userExamModel.key)
          .set(userExamModel.toJsonWithExportKeyToId());

      showDialogWait.hide(context);

      return null;
    } on FirebaseAuthException catch (e) {
      showDialogWait.hide(context);
      return e.message;
    }
  }

  Future update({
    required BuildContext context,
    required UserExamModel userExamModel,
  }) async {
    try {
      final firestoreInstance = FirebaseFirestore.instance;
      CollectionReference userExams =
          firestoreInstance.collection(firebaseCustomUserExamKey);

      await userExams
          .doc(userExamModel.key)
          .set(userExamModel.toJsonWithExportKeyToId());

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  List<String> generateCategorysIds(List<CategoryModel> categorys) {
    List<String> result = [];

    for (CategoryModel oneCategory in categorys) {
      for (int i = 1; i <= oneCategory.maxQuestions; i++) {
        result.add(QuestionModel.getKey(oneCategory, i));
      }
    }

    return result;
  }

  int _getRandomInt(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }
}
