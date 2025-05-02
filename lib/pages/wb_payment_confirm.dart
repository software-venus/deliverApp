import 'package:flutter/material.dart';
import 'package:entrega/main.dart';
import 'package:entrega/utils/checkout/base_payment_controller.dart';
import 'package:entrega/variables/globalvar.dart';
import 'package:entrega/widgets/application_bar_without_back_button.dart';
import 'package:entrega/widgets/text_view_format.dart';

// ignore: must_be_immutable
class WBPaymentConfirm extends StatefulWidget {
  String responseMessage = "";
  bool isFinish = false;

  QueryParameters queryParameters;

  WBPaymentConfirm({Key? key, required this.queryParameters})
      : super(key: key);

  @override
  State<WBPaymentConfirm> createState() => WBPaymentConfirmState();
}

class WBPaymentConfirmState extends State<WBPaymentConfirm> {
  @override
  void initState() {
    super.initState();

    BasePaymentController()
        .processApproved(context, widget.queryParameters, onFinishApproved);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationBarWithoutBackButton(
          context: context,
          title: widget.responseMessage,
          withShareButton: false,
        ),
        body: Column(
          children: [
            textViewFormat(paymentConfirmResponseMessageTitle,
                Icons.message, widget.responseMessage),
          ],
        ));
  }

  onFinishApproved(String responseMessage) {
    widget.responseMessage = responseMessage;
    widget.isFinish = true;

    setState(() {});
  }
}
