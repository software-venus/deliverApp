// ignore: import_of_legacy_library_into_null_safe
import 'package:entrega/pages/home.dart';
import 'package:entrega/widgets/application_bar.dart';
import 'package:entrega/widgets/subscriptions_build.dart';
import 'package:flutter/material.dart';
import 'package:entrega/utils/general/sizes_helpers.dart';
import 'package:entrega/variables/globalvar.dart';

// ignore: must_be_immutable
class Subscriptions extends StatefulWidget {
  HomePageState homePageState;
  bool dobleClosed;

  Subscriptions({Key? key, required this.homePageState, required this.dobleClosed})
      : super(key: key);

  @override
  State<Subscriptions> createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {


  Future<bool> _onBackPressed() async {
    return true;
  }

  void init() {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: ApplicationBar(
              context: context,
              title: SubscriptionsTitle,
              withShareButton: false,
            ),
            body: subscriptionsbuild(
              widget.homePageState,
              context,
              widget.homePageState.membershipLists,
              widget.homePageState.membershipOnlyVisibleLists,
              factor(context))));
  }
}
