import 'package:flutter/material.dart';
import 'package:mdexam/utils/general/sizes_helpers.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class CustomWebView extends StatefulWidget {
  String title;
  String url;
  CustomWebView({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (isMobile()) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*      
        appBar: ApplicationBarCustomer(
            context: context,
            title: widget.title,
            backgroundColor: primaryColor,
            withRefreshWeb: false,
            homePageState: null),
*/

        body: Stack(
      children: [
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.url,
        ),
      ],
    ));
  }
}
