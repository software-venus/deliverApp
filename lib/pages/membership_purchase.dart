import 'dart:async';

import 'package:entrega/models/membership_model.dart';
import 'package:entrega/models/user_membership_purchase_model.dart';
import 'package:entrega/pages/home.dart';
import 'package:entrega/utils/checkout/paypal/v1/paypal_v1_payment_controller.dart';
import 'package:entrega/utils/checkout/stripe/stripe_payment_controller.dart';
import 'package:entrega/utils/firebase/firebase_custom_membership.dart';
import 'package:entrega/utils/fixvalues/user_membership_purchase_status_values.dart';
import 'package:entrega/utils/general/sizes_helpers.dart';
import 'package:entrega/widgets/application_bar.dart';
import 'package:flutter/material.dart';
import 'package:entrega/variables/globalvar.dart';
import 'package:entrega/widgets/membership_build.dart';
import 'package:entrega/widgets/option_build.dart';
import 'package:translator/translator.dart';

// ignore: must_be_immutable
class MembershipPurchase extends StatefulWidget {
  HomePageState homePageState;
  MembershipModel toMembership;

  MembershipPurchase(
      {Key? key, required this.homePageState, required this.toMembership})
      : super(key: key);

  @override
  State<MembershipPurchase> createState() => _MembershipPurchaseState();
}

class _MembershipPurchaseState extends State<MembershipPurchase> {
  final _formKey = GlobalKey<FormState>();

  Future<bool> _onBackPressed() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: ApplicationBar(
              context: context,
              title: membershipPurchaseTitle,
              withShareButton: false,
            ),
            body: ListView(children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Column(children: [
/* Membership */
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FutureBuilder<List<String>>(
                            future: Future.wait([
                              getTranslatedDetail(widget.toMembership.title, languageStatus),
                              getTranslatedDetail(widget.toMembership.detail, languageStatus),
                            ]),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return const Text("Error");
                              } else {
                                final translatedTitle = snapshot.data![0];
                                final translatedDetail = snapshot.data![1];

                                return membershipBuild(
                                  widget.homePageState,
                                  translatedTitle,
                                  widget.toMembership.price, // price is already a number, not translated
                                  translatedDetail,
                                  "",
                                  false,
                                  factor(context),
                                  () {},
                                  false,
                                  () {},
                                );
                              }
                            },
                          ),
                        ],
                      ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /* Credit Card */
                            optionBuild(
                                "",
                                Icons.credit_card,
                                Colors.deepPurple,
                                membershipPurchasePaymentCardTitle,
                                factor(context), () {
                              BuildContext context2 = context;

//                              if (!isMobile()) {
//                                if (Navigator.canPop(context)) {
//                                  Navigator.pop(context);
//                                }
//                              }

                              UserMembershipPurchaseModel
                                  userMembershipPurchaseModel =
                                  UserMembershipPurchaseModel(
                                      false,
                                      "",
                                      widget.homePageState.loginUsername,
                                      widget.homePageState
                                          .customerMembershipCurrent,
                                      widget.toMembership,
                                      UserMembershipPurchaseModel.unityID(
                                          widget.homePageState.loginUsername),
                                      UserMembershipPurchaseStatusValues()
                                          .userMembershipPurchaseStatusModelPending,
                                      DateTime.now().toUtc());

                              FirebaseCustomMembershipHelper()
                                  .stripePrePurchase(
                                context: context,
                                userMembershipPurchaseModel:
                                    userMembershipPurchaseModel,
                                listParameters:
                                    widget.homePageState.listParameters,
                                onFinished: () async {
                                  StripePaymentController
                                      stripePaymentController =
                                      StripePaymentController();

                                  await stripePaymentController.initParameter(
                                      widget.homePageState.listParameters);

                                  await stripePaymentController.startUrlPayment(
                                      context2,
                                      userMembershipPurchaseModel.username,
                                      userMembershipPurchaseModel
                                          .toMembership.title,
                                      1,
                                      userMembershipPurchaseModel
                                          .toMembership.price,
                                      "USD",
                                      userMembershipPurchaseModel
                                          .paymentNumber);
                                },
                                onError: (String error) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      error,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ));
                                },
                              );
                            }),
                            /* Paypal */
                            optionBuild(
                                "",
                                Icons.paypal,
                                Colors.deepPurple,
                                membershipPurchasePaymentPayPalTitle,
                                factor(context), () {
                              BuildContext context2 = context;

//                              if (!isMobile()) {
//                                if (Navigator.canPop(context)) {
//                                  Navigator.pop(context);
//                                }
//                              }

                              UserMembershipPurchaseModel
                                  userMembershipPurchaseModel =
                                  UserMembershipPurchaseModel(
                                      false,
                                      "",
                                      widget.homePageState.loginUsername,
                                      widget.homePageState
                                          .customerMembershipCurrent,
                                      widget.toMembership,
                                      UserMembershipPurchaseModel.unityID(
                                          widget.homePageState.loginUsername),
                                      UserMembershipPurchaseStatusValues()
                                          .userMembershipPurchaseStatusModelPending,
                                      DateTime.now().toUtc());

                              FirebaseCustomMembershipHelper()
                                  .paypalPrePurchase(
                                      context: context,
                                      userMembershipPurchaseModel:
                                          userMembershipPurchaseModel,
                                      listParameters:
                                          widget.homePageState.listParameters,
                                      onFinished: () async {
                                        PaypalV1PaymentController
                                            paypalV1PaymentController =
                                            PaypalV1PaymentController();

                                        await paypalV1PaymentController
                                            .initParameter(widget
                                                .homePageState.listParameters);

                                        await paypalV1PaymentController
                                            .startUrlPayment(
                                                context2,
                                                userMembershipPurchaseModel
                                                    .username,
                                                userMembershipPurchaseModel
                                                    .toMembership.title,
                                                1,
                                                userMembershipPurchaseModel
                                                    .toMembership.price,
                                                "USD",
                                                userMembershipPurchaseModel
                                                    .paymentNumber);
                                      },
                                      onError: (String error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            error,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ));
                                      });
                            }),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ])));
  }
}

Future<String> getTranslatedDetail(String text, int languageStatus) async {
    final translator = GoogleTranslator();
    return languageStatus == 0
        ? text
        : await translator.translate(text, to: "en").then((t) => t.text);
  }