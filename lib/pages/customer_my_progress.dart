import 'package:mdexam/models/category_model.dart';
import 'package:mdexam/models/user_exam_model.dart';
import 'package:mdexam/variables/globalvar.dart';
import 'package:mdexam/widgets/application_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
// import 'dart:math';

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
      ),
      body: isFinishLoad
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 20,
                        getTitlesWidget: (value, meta) => Text('${value.toInt()}%'),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < cateList.length) {
                            return Text(
                              cateList[index].title.length > 8
                                  ? cateList[index].title.substring(0, 8) + '...'
                                  : cateList[index].title,
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  barGroups: _generateBarGroups(),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    final now = DateTime.now();
    List<BarChartGroupData> barGroups = [];

    for (int i = 0; i < cateList.length; i++) {
      final category = cateList[i];

      // Find all exams linked to this category
      final relevantExams = list.where(
        (exam) => exam.categorys.any((c) => c.key == category.key)
      ).toList();

      double totalScore = 0;
      int totalCount = 0;

      double recentScore = 0;
      int recentCount = 0;

      for (var exam in relevantExams) {
        final questions = exam.questionAnswers;
        if (questions.isEmpty) continue;

        final correct = questions.where((qa) => qa.answer.isCorrect).length;
        final percent = (correct / questions.length) * 100;

        totalScore += percent;
        totalCount++;

        if (now.difference(exam.creationTime).inDays <= 30) {
          recentScore += percent;
          recentCount++;
        }
      }

      double avgTotal = totalCount > 0 ? totalScore / totalCount : 0;
      double avgRecent = recentCount > 0 ? recentScore / recentCount : 0;

      barGroups.add(
        BarChartGroupData(
          x: i,
          barsSpace: 4,
          barRods: [
            BarChartRodData(toY: avgRecent, width: 8, color: Colors.blue),
            BarChartRodData(toY: avgTotal, width: 8, color: Colors.green),
          ],
        ),
      );
    }

    return barGroups;
  }


}