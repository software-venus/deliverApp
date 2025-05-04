// ignore_for_file: unnecessary_null_comparison

import 'package:entrega/models/membership_model.dart';
import 'package:entrega/pages/membership_list.dart';
import 'package:entrega/utils/firebase/firebase_custom_membership.dart';
import 'package:entrega/widgets/application_bar.dart';
import 'package:entrega/utils/general/abm.dart';
import 'package:entrega/utils/general/reference_Page_State.dart';
import 'package:flutter/material.dart';
import 'package:entrega/variables/globalvar.dart';

// ignore: must_be_immutable
class MembershipABM extends StatefulWidget {
  MembershipListState membershipListState;
  final bool isNew;
  bool isModify;
  MembershipModel membershipModel;

  MembershipABM({
    Key? key,
    required this.membershipListState,
    required this.isNew,
    required this.isModify,
    required this.membershipModel,
  }) : super(key: key);

  @override
  State<MembershipABM> createState() => _MembershipABMState();
}

class _MembershipABMState extends State<MembershipABM> {
  final _titleController = TextEditingController();
  final _detailController = TextEditingController();
  final _priceController = TextEditingController();
  final _maxTracksController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<bool> _onBackPressed() async {
    return abmOnBackPressed2(context, () {}, () {});
  }

  @override
  void initState() {
    if (widget.isModify) {
      _titleController.text = widget.membershipModel.title;
      _detailController.text = widget.membershipModel.detail;
      _priceController.text = widget.membershipModel.price.toString();
      _maxTracksController.text = widget.membershipModel.maxTracks.toString();
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
              title: membershipABMTitle,
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
                                hintText: membershipABMFieldTitleHint,
                                labelText: membershipABMFieldTitleLabel,
                              ),
                              controller: _titleController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return membershipABMFieldTitleError;
                                }
                                return null;
                              },
                              onChanged: (value) {
                                widget.membershipModel.title = value;
                              },
                            ),

/* Detail */
                            TextFormField(
                              decoration: InputDecoration(
                                icon: const Icon(Icons.title_rounded),
                                hintText: membershipABMFieldDetailHint,
                                labelText: membershipABMFieldDetailLabel,
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: _detailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return membershipABMFieldDetailError;
                                }
                                return null;
                              },
                              onChanged: (value) {
                                widget.membershipModel.detail = value;
                              },
                            ),

/* Price */
                            TextFormField(
                              decoration: InputDecoration(
                                icon: const Icon(Icons.money_rounded),
                                hintText: membershipABMFieldPriceHint,
                                labelText: membershipABMFieldPriceLabel,
                              ),
                              controller: _priceController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return membershipABMFieldPriceError;
                                }
                                return null;
                              },
                              onChanged: (value) {
                                widget.membershipModel.price =
                                    double.parse(value);
                              },
                            ),

/* IsVisible */
                            Row(
                              children: [
                                Checkbox(
                                    value: widget.membershipModel.isAds,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        widget.membershipModel.isAds =
                                            value!;
                                      });
                                    }),
                                Text(membershipABMFieldIsVisibleLabel),
                              ],
                            ),

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
/* Membership New */
                                        if (widget.isNew) {
                                          try {
                                            String error = "";

                                            if (_titleController.text.isEmpty) {
                                              error =
                                                  membershipABMFieldTitleError;
                                            }

                                            if (_detailController
                                                .text.isEmpty) {
                                              error =
                                                  membershipABMFieldDetailError;
                                            }

                                            try {
                                              double.parse(
                                                  _priceController.text);
                                            } catch (errorValue) {
                                              error =
                                                  membershipABMFieldPriceError;
                                            }

                                            try {
                                              double tValuePrice = double.parse(
                                                  _priceController.text);

                                              if (tValuePrice < 0) {
                                                error =
                                                    membershipABMFieldPriceError;
                                              }
                                            } catch (errorValue) {
                                              error =
                                                  membershipABMFieldPriceError;
                                            }

                                            try {
                                              double.parse(
                                                  _maxTracksController.text);
                                            } catch (errorValue) {
                                              error =
                                                  membershipABMFieldMaxTracksError;
                                            }
                                            try {
                                              int tValueMaxTracks = int.parse(
                                                  _maxTracksController.text);

                                              if (tValueMaxTracks < 1) {
                                                error =
                                                    membershipABMFieldMaxTracksError;
                                              }
                                            } catch (errorValue) {
                                              error =
                                                  membershipABMFieldMaxTracksError;
                                            }

                                            if (error.isEmpty) {
                                              FirebaseCustomMembershipHelper()
                                                  .add(
                                                context: context,
                                                membershipModel:
                                                    widget.membershipModel,
                                              )
                                                  .then((result) {
                                                if (result == null) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          SnackBar(
                                                    content: Text(
                                                      membershipABMNewSaved,
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ));
                                                  Navigator.pop(context);

                                                  if (widget
                                                          .membershipListState !=
                                                      null) {
                                                    widget.membershipListState
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

/* Membership Modify */
                                        if (widget.isModify) {
                                          try {
                                            String error = "";

                                            if (_titleController.text.isEmpty) {
                                              error =
                                                  membershipABMFieldTitleError;
                                            }

                                            if (_detailController
                                                .text.isEmpty) {
                                              error =
                                                  membershipABMFieldDetailError;
                                            }

                                            try {
                                              double.parse(
                                                  _priceController.text);
                                            } catch (errorValue) {
                                              error =
                                                  membershipABMFieldPriceError;
                                            }

                                            try {
                                              double tValuePrice = double.parse(
                                                  _priceController.text);

                                              if (tValuePrice < 0) {
                                                error =
                                                    membershipABMFieldPriceError;
                                              }
                                            } catch (errorValue) {
                                              error =
                                                  membershipABMFieldPriceError;
                                            }

                                            try {
                                              double.parse(
                                                  _maxTracksController.text);
                                            } catch (errorValue) {
                                              error =
                                                  membershipABMFieldMaxTracksError;
                                            }
                                            try {
                                              int tValueMaxUses = int.parse(
                                                  _maxTracksController.text);

                                              if (tValueMaxUses < 1) {
                                                error =
                                                    membershipABMFieldMaxTracksError;
                                              }
                                            } catch (errorValue) {
                                              error =
                                                  membershipABMFieldMaxTracksError;
                                            }

                                            if (error.isEmpty) {
                                              FirebaseCustomMembershipHelper()
                                                  .modify(
                                                context: context,
                                                membershipModel:
                                                    widget.membershipModel,
                                              )
                                                  .then((result) {
                                                if (result == null) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          SnackBar(
                                                    content: Text(
                                                      membershipABMModifySaved,
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ));
                                                  Navigator.pop(context);

                                                  if (widget
                                                          .membershipListState !=
                                                      null) {
                                                    widget.membershipListState
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
                                    child: Text(membershipABMSaveTitle),
                                  ),
                                ),
                              ),

/* Membership Delete */
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 40, bottom: 20),
                                child: widget.isModify
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Center(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20,
                                                        vertical: 9),
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                                onPressed: () async {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: Text(
                                                          abmDeleteAlertTitle),
                                                      content: Text(
                                                          abmDeleteAlertContent),
                                                      actions: <Widget>[
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              const SizedBox(
                                                                  height: 50),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          true);

                                                                  FirebaseCustomMembershipHelper()
                                                                      .delete(
                                                                          context:
                                                                              context,
                                                                          membershipModel: widget
                                                                              .membershipModel)
                                                                      .then(
                                                                          (result) {
                                                                    if (result ==
                                                                        null) {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              SnackBar(
                                                                        content:
                                                                            Text(
                                                                          membershipABMModifyDelete,
                                                                          style:
                                                                              const TextStyle(fontSize: 16),
                                                                        ),
                                                                      ));
/*
                                                                      if (widget
                                                                              .membershipListState !=null) {
                                                                        widget
                                                                            .membershipListState?.refreshList();
                                                                      }
*/
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    } else {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              SnackBar(
                                                                        content:
                                                                            Text(
                                                                          result,
                                                                          style:
                                                                              const TextStyle(fontSize: 16),
                                                                        ),
                                                                      ));
                                                                    }
                                                                  });
                                                                },
                                                                child: Text(
                                                                    abmDeleteAlertPressedYes),
                                                              ),
                                                              const SizedBox(
                                                                  height: 50),
                                                              GestureDetector(
                                                                onTap: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            false),
                                                                child: Text(
                                                                    abmDeleteAlertPressedNo),
                                                              ),
                                                              const SizedBox(
                                                                  height: 50),
                                                            ])
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  abmDeleteTitle,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ))))
                                    : Container(),
                              ),
                            ])
                          ])))
            ])));
  }
}

class MembershipABMReferenceState extends ReferencePageState {
  _MembershipABMState membershipABMState;

  MembershipABMReferenceState(this.membershipABMState);

  @override
  void setStates() {
    // ignore: invalid_use_of_protected_member
    membershipABMState.setState(() {});
  }
}
