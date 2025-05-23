import 'package:entrega/models/membership_model.dart';
import 'package:entrega/models/parameter_model.dart';
import 'package:entrega/models/user_model.dart';
import 'package:entrega/pages/home.dart';
import 'package:entrega/pages/membership_purchase.dart';
import 'package:entrega/pages/user_login.dart';
import 'package:entrega/pages/user_simple_add.dart';
import 'package:entrega/utils/general/sizes_helpers.dart';
import 'package:entrega/utils/list_transforms/parameter_list_transforms.dart';
import 'package:entrega/variables/globalvar.dart';
import 'package:flutter/material.dart';
import 'package:entrega/widgets/membership_build.dart';
import 'package:entrega/widgets/menu.dart';
import 'package:translator/translator.dart';

Widget subscriptionsbuild(
    HomePageState homePageState,
    BuildContext context,
    List<MembershipModel> memberships,
    List<MembershipModel> membershipOnlyVisibles,
    double factor) {
  // String appSubTitle = "";
  bool showMembership = false;

  if (homePageState.listParameters.isNotEmpty) {
    // ParameterModel appSubTitleParameter =
    //     parameterStringFromKey2ToParameterModel(
    //         homePageState.listParameters, "appSubTitle");

    // appSubTitle = appSubTitleParameter.additional;

    ParameterModel youTubeParameter = parameterStringFromKey2ToParameterModel(
        homePageState.listParameters, "youTube");

    if (youTubeParameter.key2.compareTo("youTube") == 0 &&
        youTubeParameter.additional.compareTo("youTubeNot") != 0) {
    }

    if (!isIOS()) {

      showMembership = true;
    } else {
      ParameterModel iosShowMembershipParameter =
          parameterStringFromKey2ToParameterModel(
              homePageState.listParameters, "iosShowMembership");

      if (iosShowMembershipParameter.key2.compareTo("iosShowMembership") == 0 &&
          iosShowMembershipParameter.additional.compareTo("Si") == 0) {
        showMembership = true;
      }

      ParameterModel iosPurchaseMembershipParameter =
          parameterStringFromKey2ToParameterModel(
              homePageState.listParameters, "iosPurchaseMembership");

      if (iosPurchaseMembershipParameter.key2
                  .compareTo("iosPurchaseMembership") ==
              0 &&
          iosPurchaseMembershipParameter.additional.compareTo("Si") == 0) {
      }
    }
  }

  return Container(
      color: customBackcolor,
      child: ListView(children: [


/* Memberships */
        showMembership
            ? Column(children: [
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: displayWidth(context),
                  child: Text(
                    appMembershipTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                displayWidth(context) < 800
                    ? membershipBuildListViewX2(
                        homePageState, context, membershipOnlyVisibles, factor)
                    : displayWidth(context) < 1300
                        ? membershipBuildListViewX3(homePageState, context,
                            membershipOnlyVisibles, factor)
                        : membershipBuildListViewX4(homePageState, context,
                            membershipOnlyVisibles, factor)
              ])
            : Container()
      ]));
}

Widget membershipBuildListViewX2(
    HomePageState homePageState,
    BuildContext context,
    List<MembershipModel> list,
    double factor) {
      // print(list);
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: (list.length / 2).ceil(),
    itemBuilder: (BuildContext context, int widgetIndex) {
      int base = widgetIndex * 2;
      int index1 = base;
      int index2 = base + 1;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          index1 < list.length
              ? FutureBuilder<Widget>(
                  future: membershipOneItem(
                      homePageState, context, list, index1, factor),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        child: const SizedBox(
                          width: 80,
                          height: 80,
                          child: Center(
                              child: CircularProgressIndicator(strokeWidth: 2)),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        child: const Text("Error"),
                      );
                    } else {
                      return snapshot.data!;
                    }
                  },
                )
              : Container(),

          index2 < list.length
              ? FutureBuilder<Widget>(
                  future: membershipOneItem(
                      homePageState, context, list, index2, factor),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        child: const SizedBox(
                          width: 80,
                          height: 80,
                          child: Center(
                              child: CircularProgressIndicator(strokeWidth: 2)),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        child: const Text("Error"),
                      );
                    } else {
                      return snapshot.data!;
                    }
                  },
                )
              : Container(),
        ],
      );
    },
  );
}



Widget membershipBuildListViewX3(
    HomePageState homePageState,
    BuildContext context,
    List<MembershipModel> list,
    double factor) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: (list.length / 3).ceil(),
    itemBuilder: (BuildContext context, int widgetIndex) {
      int base = widgetIndex * 3;
      int index1 = base;
      int index2 = base + 1;
      int index3 = base + 2;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          index1 < list.length
              ? FutureBuilder<Widget>(
                  future: membershipOneItem(
                      homePageState, context, list, index1, factor),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        child: const SizedBox(
                          width: 80,
                          height: 80,
                          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        child: const Text("Error"),
                      );
                    } else {
                      return snapshot.data!;
                    }
                  },
                )
              : Container(),

          index2 < list.length
              ? FutureBuilder<Widget>(
                  future: membershipOneItem(
                      homePageState, context, list, index2, factor),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        child: const SizedBox(
                          width: 80,
                          height: 80,
                          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        child: const Text("Error"),
                      );
                    } else {
                      return snapshot.data!;
                    }
                  },
                )
              : Container(),

          index3 < list.length
              ? FutureBuilder<Widget>(
                  future: membershipOneItem(
                      homePageState, context, list, index3, factor),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        child: const SizedBox(
                          width: 80,
                          height: 80,
                          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        child: const Text("Error"),
                      );
                    } else {
                      return snapshot.data!;
                    }
                  },
                )
              : Container(),
        ],
      );
    },
  );
}



Widget membershipBuildListViewX4(
    HomePageState homePageState,
    BuildContext context,
    List<MembershipModel> list,
    double factor) {
  return ListView.builder(
    
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: (list.length / 4).ceil(),
    itemBuilder: (BuildContext context, int widgetIndex) {
      int base = widgetIndex * 4;
      int index1 = base;
      int index2 = base + 1;
      int index3 = base + 2;
      int index4 = base + 3;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          index1 < list.length
              ? FutureBuilder<Widget>(
                  future: membershipOneItem(homePageState, context, list, index1, factor),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Text("Error");
                    } else {
                      return snapshot.data!;
                    }
                  },
                )
              : Container(),

          index2 < list.length
              ? FutureBuilder<Widget>(
                  future: membershipOneItem(homePageState, context, list, index2, factor),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Text("Error");
                    } else {
                      return snapshot.data!;
                    }
                  },
                )
              : Container(),

          index3 < list.length
              ? FutureBuilder<Widget>(
                  future: membershipOneItem(homePageState, context, list, index3, factor),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Text("Error");
                    } else {
                      return snapshot.data!;
                    }
                  },
                )
              : Container(),

          index4 < list.length
              ? FutureBuilder<Widget>(
                  future: membershipOneItem(homePageState, context, list, index4, factor),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Text("Error");
                    } else {
                      return snapshot.data!;
                    }
                  },
                )
              : Container(),
        ],
      );
    },
  );
}



Future<String> getTranslatedDetail(String text, int languageStatus) async {
    final translator = GoogleTranslator();
    return languageStatus == 0
        ? text
        : await translator.translate(text, to: "en").then((t) => t.text);
}

Future<Widget> membershipOneItem(HomePageState homePageState, BuildContext context,
    List<MembershipModel> list, int index, double factor) async {
  final MembershipModel membershipModel = list[index];
  String title = await getTranslatedDetail(membershipModel.title, languageStatus);
  String detail = await getTranslatedDetail(membershipModel.detail, languageStatus);
  return membershipBuild(
      homePageState,
      title,
      membershipModel.price,
      detail,
      !membershipModel.isAds
          ? membershipSelectTitle
          : membershipSelectNewTitle,
      !membershipModel.isAds,
      factor,
      () {
        !homePageState.isLogin
            ? Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => UserLogin(
                    homePageState: homePageState,
                    dobleClosed: false,
                  ),
                ),
              )
            : Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => MembershipPurchase(
                      homePageState: homePageState,
                      toMembership: membershipModel),
                ),
              );
      },
      membershipModel.isAds && !homePageState.isLogin,
      () {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => UserSimpleAdd(
                homePageState: homePageState,
                referencePageState: MenuReferencePageState(homePageState),
                isNew: true,
                isModify: false,
                userModel: UserModel("", "", true, false, false, true, "", ""),
                isOriginSelectAdd: true,
                memberships: homePageState.membershipLists),
          ),
        );
      });
}

String membershipDays(HomePageState homePageState) {
  Duration diference = homePageState.customerMembershipCurrent.creationTime
      .difference(DateTime.now().toUtc());

  if (diference.inDays <= 0) {
    return appMembershipDays0Title;
  } else {
    return appMembershipDaysPreTitle +
        " " +
        diference.inDays.toString() +
        " " +
        appMembershipDaysSubTitle;
  }
}

void iosPurchaseMembershipController(MembershipModel membershipModel) {
  try {} catch (e) {
    e.toString();
  }
}
