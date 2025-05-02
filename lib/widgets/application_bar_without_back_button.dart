// ignore: import_of_legacy_library_into_null_safe
import 'package:entrega/pages/home.dart';
import 'package:entrega/utils/general/sizes_helpers.dart';
import 'package:entrega/variables/globalvar.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

// ignore: must_be_immutable
class ApplicationBarWithoutBackButton extends AppBar {
  HomePageState? homePageState;

  ApplicationBarWithoutBackButton({
    Key? key,
    required BuildContext context,
    required String title,
    bool withShareButton = false,
    bool withRefreshWeb = false,
    backgroundColor = primaryColor,
    this.homePageState,
  }) : super(
            automaticallyImplyLeading: false,
            key: key,
            title: Text(title),
            backgroundColor: backgroundColor,
            iconTheme: const IconThemeData(
                color: Colors.white, opacity: 100, size: 30),
            actions: <Widget>[
              withShareButton
                  ? Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () => _onShare(context),
                        child: const Icon(Icons.share_rounded),
                      ))
                  : Container(),
              (withRefreshWeb && isWeb())
                  ? Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () => _onRefresh(homePageState!, context),
                        child: const Icon(Icons.refresh_rounded),
                      ))
                  : Container(),
            ]);
}

_onShare(BuildContext context) async {
  final RenderBox box = context.findRenderObject() as RenderBox;

  await Share.share(appName,
      subject: shareText,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}

_onRefresh(HomePageState homePageState, BuildContext context) async {
  homePageState.globalRefresh();
}
