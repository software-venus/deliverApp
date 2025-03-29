import 'package:mdexam/models/category_model.dart';
import 'package:mdexam/models/user_exam_model.dart';
import 'package:mdexam/variables/globalvar.dart';
import 'package:mdexam/widgets/application_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomerMyProgress extends StatefulWidget {
  String loginUsername;

  CustomerMyProgress({Key? key, required this.loginUsername}) : super(key: key);

  @override
  State<CustomerMyProgress> createState() => CustomerMyExamListState();
}

class CustomerMyExamListState extends State<CustomerMyProgress> {
  List<UserExamModel> list = [];
  List<CategoryModel> cateList = [];

  bool isFinishLoad = false;

  @override
  void initState() {
    super.initState();

    loadMyExamListView();
  }

  Future<void> loadMyExamListView() async {
    try {
      list.clear();

      final firestoreInstance = FirebaseFirestore.instance;
      CollectionReference myExams =
          firestoreInstance.collection(firebaseCustomUserExamKey);

      CollectionReference myCategory = 
          firestoreInstance.collection(firebaseCustomCategoryKey);

      myExams
          .where("username", isEqualTo: widget.loginUsername)
          .orderBy("creationTime", descending: true)
          .limit(30)
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          setState(() {
            list.add(UserExamModel.fromJSON(false, result.id, result.data()));
          });
        }

        isFinishLoad = true;
      });

      myCategory
          .orderBy("creationTime", descending: true)
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          setState(() {
            cateList.add(CategoryModel.fromJSON(false, result.id, result.data()));
          });
        }

        isFinishLoad = true;
      });

      setState(() {});
    } on FirebaseAuthException catch (e) {
      e.stackTrace;
    }
  }

  void refreshList() {
    loadMyExamListView();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationBar(
          context: context,
          title: menuProfilerCustomerProgressMyExamsTitle,
          withShareButton: false,
        )
      );
  }
}