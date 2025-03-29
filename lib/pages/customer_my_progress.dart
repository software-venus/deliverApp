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
        ? SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.3,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 100,
                      minY: 0,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.grey[900],
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            String label =
                                rodIndex == 0 ? 'Last 30 Days' : 'All Time';
                            return BarTooltipItem(
                              '$label\n',
                              const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: '${rod.toY.toStringAsFixed(1)}%',
                                  style: const TextStyle(
                                      color: Colors.tealAccent,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 20,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) => Text(
                              '${value.toInt()}%',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index < cateList.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    cateList[index].title.length > 10
                                        ? cateList[index]
                                                .title
                                                .substring(0, 10) +
                                            '…'
                                        : cateList[index].title,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles:
                            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(
                        show: true,
                        horizontalInterval: 20,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: Colors.grey.withOpacity(0.2),
                          strokeWidth: 1,
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: _generateBarGroups(),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildLegend(),
              ],
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

      final relevantExams = list.where(
        (exam) => exam.categorys.any((c) => c.key == category.key),
      ).toList();

      double totalScore = 0;
      int totalCount = 0;

      double recentScore = 0;
      int recentCount = 0;

      for (var exam in relevantExams) {
        if (exam.questionAnswers.isEmpty) continue;

        final correct = exam.questionAnswers
            .where((qa) => qa.answer.isCorrect)
            .length;
        final percent =
            (correct / exam.questionAnswers.length) * 100;

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
          barsSpace: 6,
          barRods: [
            BarChartRodData(
              toY: avgRecent,
              width: 10,
              borderRadius: BorderRadius.circular(6),
              color: Colors.tealAccent.shade400,
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: 100,
                color: Colors.tealAccent.shade100.withOpacity(0.1),
              ),
            ),
            BarChartRodData(
              toY: avgTotal,
              width: 10,
              borderRadius: BorderRadius.circular(6),
              color: Colors.blue.shade400,
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: 100,
                color: Colors.blue.shade100.withOpacity(0.1),
              ),
            ),
          ],
        ),
      );
    }

    return barGroups;
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(Colors.tealAccent.shade400, 'Last 30 Days'),
        const SizedBox(width: 24),
        _legendItem(Colors.blue.shade400, 'Right Now'),
      ],
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }



}