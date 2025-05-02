import 'package:entrega/models/answer_model.dart';
import 'package:entrega/models/category_model.dart';
import 'package:entrega/models/question_model.dart';
import 'package:entrega/pages/question_abm.dart';
import 'package:entrega/widgets/application_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:entrega/variables/globalvar.dart';

// ignore: must_be_immutable
class QuestionList extends StatefulWidget {
  const QuestionList({Key? key}) : super(key: key);

  @override
  State<QuestionList> createState() => QuestionListState();
}

class QuestionListState extends State<QuestionList> {
  List<QuestionModel> list = [];

  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    loadQuestionsListView();
  }

  Future<void> loadQuestionsListView() async {
    try {
      list.clear();

      final firestoreInstance = FirebaseFirestore.instance;
      CollectionReference questions =
          firestoreInstance.collection(firebaseCustomQuestionKey);

      if (_searchTextController.text.isEmpty) {
        questions
            .orderBy("creationTime", descending: true)
            .limit(30)
            .get()
            .then((querySnapshot) {
          for (var result in querySnapshot.docs) {
            setState(() {
              list.add(QuestionModel.fromJSON(false, result.id, result.data()));
            });
          }
        });
      } else {
        questions
            .where("arraySearch",
                arrayContains: _searchTextController.text.toLowerCase())
            .orderBy("creationTime", descending: true)
            .limit(30)
            .get()
            .then((querySnapshot) {
          for (var result in querySnapshot.docs) {
            setState(() {
              list.add(QuestionModel.fromJSON(false, result.id, result.data()));
            });
          }
        });
      }

      setState(() {});
    } on FirebaseAuthException catch (e) {
      e.stackTrace;
    }
  }

  void refreshList() {
    loadQuestionsListView();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationBar(
          context: context,
          title: questionListTitle,
          withShareButton: false,
        ),
        body: RefreshIndicator(
            key: const Key("refreshKey"),
            onRefresh: () async {
              refreshList();
            },
            child: ListView(children: [
              buildAddButtom(),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                      controller: _searchTextController,
                      textInputAction: TextInputAction.go,
                      onSubmitted: (String value) {
                        loadQuestionsListView();
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(5),
                          prefixIconConstraints:
                              const BoxConstraints(maxWidth: 60, minWidth: 60),
                          prefixIcon: const Icon(Icons.search_rounded, size: 30),
                          suffixIconConstraints:
                              const BoxConstraints(maxWidth: 60, minWidth: 60),
                          hintText: filterSearchTextHintText,
                          labelText: filterSearchTextHintText,
                          alignLabelWithHint: true,
                          labelStyle: const TextStyle(fontSize: 18),
                          filled: true,
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)))))),
              buildListView(context, list),
            ])));
  }

  Widget buildAddButtom() {
    return Column(children: <Widget>[
      Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                AnswerModel answer1 = AnswerModel("", false);
                AnswerModel answer2 = AnswerModel("", false);
                AnswerModel answer3 = AnswerModel("", false);
                AnswerModel answer4 = AnswerModel("", false);
                AnswerModel answer5 = AnswerModel("", false);

                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => QuestionABM(
                      questionListState: this,
                      isNew: true,
                      isModify: false,
                      questionModel: QuestionModel(
                          false,
                          "",
                          CategoryModel(
                              false, "", "", 0, DateTime.now().toUtc()),
                          "",
                          "",
                          "",
                          [answer1, answer2, answer3, answer4, answer5],
                          true,
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          DateTime.now()),
                    ),
                  ),
                );
              },
            ),
          )),
    ]);
  }

  Widget buildListView(BuildContext context, List<QuestionModel> list) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int widgetIndex) {
          return oneItem(context, list, widgetIndex);
        });
  }

  Widget oneItem(BuildContext context, List<QuestionModel> list, int index) {
    final QuestionModel questionModel = list[index];

    return Container(
      margin: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => QuestionABM(
                    questionListState: this,
                    isNew: false,
                    isModify: true,
                    questionModel: questionModel),
              ),
            );
          },
          leading: const Icon(Icons.question_answer_outlined),
          title: Text(
            questionModel.title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

/*
void callDelete_2(BuildContext context, QuestionListState questionListState,
    QuestionModel questionModel) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(abmDeleteAlertTitle),
      content: const Text(abmDeleteAlertContent),
      actions: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);

                  FirebaseCustomQuestionHelper()
                      .setDelete(context: context, questionModel: questionModel)
                      .then((result) {
                    if (result == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          questionABMModifyDelete,
                          style: TextStyle(fontSize: 16),
                        ),
                      ));

                      // ignore: unnecessary_null_comparison
                      if (questionListState != null) {
                        questionListState.refreshList();
                      }
//                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          result,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ));
                    }
                  });
                },
                child: const Text(abmDeleteAlertPressedYes),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: const Text(abmDeleteAlertPressedNo),
              ),
              const SizedBox(height: 50),
            ])
      ],
    ),
  );
}
*/