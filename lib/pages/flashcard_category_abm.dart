// ignore_for_file: unnecessary_null_comparison

import 'package:entrega/models/flashcard_category_model.dart';
import 'package:entrega/pages/flashcard_category_list.dart';
import 'package:entrega/utils/firebase/firebase_custom_flashcard_category.dart';
import 'package:entrega/widgets/application_bar.dart';
import 'package:entrega/utils/general/abm.dart';
import 'package:entrega/utils/general/reference_Page_State.dart';
import 'package:flutter/material.dart';
import 'package:entrega/variables/globalvar.dart';

// ignore: must_be_immutable
class FlashcardCategoryABM extends StatefulWidget {
  FlashcardCategoryListState categoryListState;
  final bool isNew;
  bool isModify;
  FlashcardCategoryModel categoryModel;

  FlashcardCategoryABM({
    Key? key,
    required this.categoryListState,
    required this.isNew,
    required this.isModify,
    required this.categoryModel,
  }) : super(key: key);

  @override
  State<FlashcardCategoryABM> createState() => _FlashcardCategoryABMState();
}

class _FlashcardCategoryABMState extends State<FlashcardCategoryABM> {
  final _titleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<bool> _onBackPressed() async {
    return abmOnBackPressed2(context, () {}, () {});
  }

  @override
  void initState() {
    if (widget.isModify) {
      _titleController.text = widget.categoryModel.title;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: ApplicationBar(
              context: context,
              title: flashcardCategoryABMTitle,
              withShareButton: false,
            ),
            body: ListView(children: [
              Form(
                  key: _formKey,
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
/* Title */
                            TextFormField(
                              decoration: InputDecoration(
                                icon: const Icon(Icons.title_rounded),
                                hintText: flashcardCategoryABMFieldTitleHint,
                                labelText: flashcardCategoryABMFieldTitleLabel,
                              ),
                              controller: _titleController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return flashcardCategoryABMFieldTitleError;
                                }
                                return null;
                              },
                              onChanged: (value) {
                                widget.categoryModel.title = value;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),

/* maxQuestions */
                            widget.isModify
                                ? Text(
                                    menuProfilerAdministratorFlashcardQuestionListTitle +
                                        ": " +
                                        widget.categoryModel.maxQuestions
                                            .toString())
                                : Container(),

/* Finish */
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 40, bottom: 20),
                                child: Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 9),
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal)),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
/* Flashcard Category New */
                                        if (widget.isNew) {
                                          try {
                                            String error = "";

                                            if (_titleController.text.isEmpty) {
                                              error =
                                                  flashcardCategoryABMFieldTitleError;
                                            }

                                            if (error.isEmpty) {
                                              FirebaseCustomFlashcardCategoryHelper()
                                                  .add(
                                                context: context,
                                                categoryModel:
                                                    widget.categoryModel,
                                              )
                                                  .then((result) {
                                                if (result == null) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          SnackBar(
                                                    content: Text(
                                                      flashcardCategoryABMNewSaved,
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ));
                                                  Navigator.pop(context);

                                                  if (widget
                                                          .categoryListState !=
                                                      null) {
                                                    widget.categoryListState
                                                        .refreshList();
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                      result,
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ));
                                                }
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  error,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                              ));
                                            }
                                          } catch (errorValue) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                errorValue.toString(),
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ));
                                          }
                                        }

/* Flashcard Category Modify */
                                        if (widget.isModify) {
                                          try {
                                            String error = "";

                                            if (_titleController.text.isEmpty) {
                                              error =
                                                  flashcardCategoryABMFieldTitleError;
                                            }

                                            if (error.isEmpty) {
                                              FirebaseCustomFlashcardCategoryHelper()
                                                  .modify(
                                                context: context,
                                                categoryModel:
                                                    widget.categoryModel,
                                              )
                                                  .then((result) {
                                                if (result == null) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          SnackBar(
                                                    content: Text(
                                                      flashcardCategoryABMModifySaved,
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ));
                                                  Navigator.pop(context);

                                                  if (widget
                                                          .categoryListState !=
                                                      null) {
                                                    widget.categoryListState
                                                        .refreshList();
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                      result,
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ));
                                                }
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  error,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                              ));
                                            }
                                          } catch (errorValue) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                errorValue.toString(),
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ));
                                          }
                                        }
                                      }
                                    },
                                    child: Text(flashcardCategoryABMSaveTitle),
                                  ),
                                ),
                              ),
                            ])
                          ])))
            ])));
  }
}

class FlashcardCategoryABMReferenceState extends ReferencePageState {
  _FlashcardCategoryABMState flashcardCategoryABMState;

  FlashcardCategoryABMReferenceState(this.flashcardCategoryABMState);

  @override
  void setStates() {
    // ignore: invalid_use_of_protected_member
    flashcardCategoryABMState.setState(() {});
  }
}
