import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mdexam/models/user_exam_model.dart';
import 'package:mdexam/pages/home.dart';
import 'package:mdexam/pages/question_report.dart';
import 'package:mdexam/utils/firebase/firebase_custom_user_exam.dart';
import 'package:mdexam/utils/general/abm.dart';
import 'package:mdexam/utils/general/clock_timer.dart';
import 'package:mdexam/utils/general/sizes_helpers.dart';
import 'package:mdexam/variables/globalvar.dart';
import 'package:mdexam/widgets/application_bar.dart';
import 'package:mdexam/widgets/question_answer_build.dart';
import 'package:translator/translator.dart';

// ignore: must_be_immutable
class QuestionRun extends StatefulWidget {
  HomePageState homePageState;
  String keyUserExam;
  UserExamModel userExam;

  QuestionRun({
    Key? key,
    required this.homePageState,
    required this.keyUserExam,
    required this.userExam,
  }) : super(key: key);

  @override
  State<QuestionRun> createState() => _QuestionRunState();
}

class _QuestionRunState extends State<QuestionRun> {
  final _formKey = GlobalKey<FormState>();
  int currentQuestion = -1;
  late ClockTimer clockTimer;
  final List<TextEditingController> _preSelectValueController =
      List.generate(1000, (i) => TextEditingController());

  String translatedTitle = "...";
  String translatedCategoryTitle = "...";
  bool isTitleLoading = true;

  @override
  void initState() {
    super.initState();

    // Start Clock
    clockTimer = ClockTimer(1, true, () {
      setStates();
    });

    // Set initial question index
    if (!widget.userExam.isFinished()) {
      currentQuestion = widget.userExam.nextQuestion();
    }

    clockTimer.start();

    // Translate all required labels
    loadTranslations();
  }

  Future<void> loadTranslations() async {
    String title = await getTranslatedDetail(widget.userExam.title(), languageStatus);
    String category = await getTranslatedDetail(widget.userExam.categoryTitles(), languageStatus);

    setState(() {
      translatedTitle = title;
      translatedCategoryTitle = category;
      isTitleLoading = false;
    });
  }

  Future<bool> _onBackPressed() async {
    return abmOnBackPressed2(context, () {
      clockTimer.stop();
    }, () {});
  }

  void setStates() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: ApplicationBar(
          context: context,
          title: isTitleLoading ? "..." : translatedTitle,
          withShareButton: false,
        ),
        body: ListView(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Categories
                        Text(
                          isTitleLoading ? "..." : translatedCategoryTitle,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 15),

                        /// Question count
                        currentQuestion >= 0
                            ? Text(
                                "${currentQuestion + 1}/${widget.userExam.maxQuestions}",
                                maxLines: 1,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 5),

                        /// Time Counter
                        widget.userExam.isShowTimeCounter
                            ? Row(
                                children: [
                                  Text(
                                    questionRunTimeTitle,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  hourMinutesSecondRounder(),
                                ],
                              )
                            : Container(),

                        /// Question Answer
                        currentQuestion >= 0
                            ? questionAnswerBuild(
                                context,
                                widget.userExam.isOpen,
                                false,
                                -1,
                                widget.userExam.questionAnswers[
                                    currentQuestion >= 0 ? currentQuestion : 0],
                                _preSelectValueController[
                                    currentQuestion >= 0 ? currentQuestion : 0],
                                factor(context),
                                () {
                                  currentQuestion = widget.userExam.nextQuestion();
                                  save();
                                },
                                () {
                                  setStates();
                                },
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Translate String
  Future<String> getTranslatedDetail(String text, int languageStatus) async {
    final translator = GoogleTranslator();
    return languageStatus == 0
        ? text
        : await translator.translate(text, to: "en").then((t) => t.text);
  }

  /// Format countdown timer
  String getHourMinutesSecond(DateTime datetime) {
    try {
      if (DateTime.now().toUtc().isAfter(datetime)) {
        return "--:--:--";
      } else {
        Duration duration = datetime.difference(DateTime.now().toUtc());
        int seconds = duration.inSeconds + 1;
        double hour = (seconds / 3600).truncateToDouble();
        seconds -= (hour.toInt() * 3600);
        double minutes = (seconds / 60).truncateToDouble();
        seconds -= (minutes.toInt() * 60);

        return getHourMinuteSecondFormat(hour.toInt()) +
            ":" +
            getHourMinuteSecondFormat(minutes.toInt()) +
            ":" +
            getHourMinuteSecondFormat(seconds);
      }
    } catch (e) {
      return "";
    }
  }

  String getHourMinuteSecondFormat(int value) {
    return value < 10 ? "0$value" : value.toString();
  }

  Widget hourMinutesSecondRounder() {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.blue,
      ),
      child: Container(
        margin: const EdgeInsets.all(1),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.blue,
        ),
        child: Container(
          color: Colors.blue,
          margin: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
          child: SizedBox(
            height: 25,
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  getHourMinutesSecond(widget.userExam.endTime),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void save() async {
    try {
      if (widget.userExam.key.isNotEmpty) {
        FirebaseCustomUserExamHelper()
            .update(context: context, userExamModel: widget.userExam)
            .then((result) {
          if (result == null) {
            if (widget.userExam.isFinished()) {
              clockTimer.stop();
              Navigator.pop(context);
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      QuestionReport(userExam: widget.userExam),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(result, style: const TextStyle(fontSize: 16)),
            ));
          }
        });
      }
    } catch (errorValue) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorValue.toString(), style: const TextStyle(fontSize: 16)),
      ));
    }
  }
}
