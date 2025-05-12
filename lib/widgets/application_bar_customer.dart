import 'package:entrega/pages/home.dart';
import 'package:entrega/utils/general/sizes_helpers.dart';
import 'package:entrega/variables/globalvar.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

// ignore: must_be_immutable
class ApplicationBarCustomer extends AppBar {
  HomePageState? homePageState;
  final Function(String) updateTrackingId;

  ApplicationBarCustomer({
    Key? key,
    required BuildContext context,
    required String title,
    bool withShareButton = false,
    bool withRefreshWeb = false,
    backgroundColor = primaryColor,
    this.homePageState,
    required this.updateTrackingId,
  }) : super(
          toolbarHeight: 80,
          elevation: 0,
          key: key,
          centerTitle: true,
          backgroundColor: customAppBarColor,
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 223, 224, 224),
            opacity: 100,
            size: 30,
          ),
          title: Container(
            margin: const EdgeInsets.symmetric(vertical: 40),
            width: displayWidth(context) * 0.5, // 50% of screen width
            height: 40,
            decoration: BoxDecoration(
              color: isBlack?Colors.black45:Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: trackIdController, // Set the controller to the TextField
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                hintText: "Track ID...",
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      updateTrackingId(trackIdController.text); // Directly call the updateTrackingId function
                    },
                    child: Image.asset(
                      'assets/icons/search.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),

          actions: <Widget>[
            withShareButton
                ? Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () => _onShare(context),
                      child: const Icon(Icons.share_rounded),
                    ),
                  )
                : Container(),
          ],
        );
}

// Define a TextEditingController to manage the TextField input
TextEditingController trackIdController = TextEditingController();

_onShare(BuildContext context) async {
  final RenderBox box = context.findRenderObject() as RenderBox;

  await Share.share(
    appName,
    subject: shareText,
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  );
}


// When you click the search image, you will assign the value to the global variable

