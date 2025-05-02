// ignore: import_of_legacy_library_into_null_safe
import 'package:entrega/pages/home.dart';
import 'package:entrega/variables/globalvar.dart';
import 'package:flutter/material.dart';

Widget footerBuild(BuildContext context, HomePageState homePageState) {
  return Column(
    children: [
      Text(
         customerFooterCaption,
        style:  const TextStyle(color: Colors.black87, fontSize: 15),
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}
