import 'package:flutter/material.dart';
import 'package:entrega/main.dart';
import 'package:entrega/utils/checkout/base_payment_controller.dart';
import 'package:entrega/variables/globalvar.dart';
import 'package:entrega/widgets/application_bar.dart';
import 'package:entrega/widgets/text_view_format.dart';

// ignore: must_be_immutable
class PaymentConfirm extends StatefulWidget {
  String responseMessage = "";
  bool isFinish = false;

  QueryParameters queryParameters;

  PaymentConfirm({Key? key, required this.queryParameters}) : super(key: key);

  @override
  State<PaymentConfirm> createState() => PaymentConfirmState();
}

class PaymentConfirmState extends State<PaymentConfirm> {
  @override
  void initState() {
    super.initState();

    BasePaymentController()
        .processApproved(context, widget.queryParameters, onFinishApproved);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationBar(
          context: context,
          title: widget.responseMessage,
          withShareButton: false,
        ),
        body: Column(
          children: [
            textViewFormat(paymentConfirmResponseMessageTitle, Icons.message,
                widget.responseMessage),
            widget.isFinish
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 9),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal)),
                    onPressed: () async {
                      BasePaymentController().navigateReset();
                    },
                    child: Text(paymentConfirmCloseButtonTitle),
                  )
                : Container(),
          ],
        ));
  }

  onFinishApproved(String responseMessage) {
    widget.responseMessage = responseMessage;
    widget.isFinish = true;

    BasePaymentController().navigateReset();

    setState(() {});
  }
}
