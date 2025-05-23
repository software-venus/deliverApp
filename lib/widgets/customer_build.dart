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
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:translator/translator.dart';
import 'package:entrega/models/tracking_model.dart';
// import 'package:entrega/widgets/subscriptions_build.dart';
// import 'package:entrega/widgets/tracking_build.dart';

Widget customerBuild(
    HomePageState homePageState,
    BuildContext context,
    List<MembershipModel> memberships,
    List<MembershipModel> membershipOnlyVisibles,
    double factor,
    TrackingModel trackingData
    ) {
  // String appSubTitle = "";
  bool youTubeShow = false;
  String youTubeID = "";
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
      youTubeID = youTubeParameter.additional;
      youTubeShow = true;
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

  final _controller = YoutubePlayerController.fromVideoId(
    videoId: youTubeID,
    autoPlay: false,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );

  return Container(
      color: customBackcolor,
      child: ListView(children: [
        homePageState.isLogin
            ? Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                    width: displayWidth(context),
                    child: Text(
                      appHomeWelcome + " " + homePageState.loginCustomerName,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: textDarkWhiteMode,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    )))
            : Container(),
/* Days */
        homePageState.isLogin
            ? Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                    width: displayWidth(context),
                    child: Text(
                      membershipDays(homePageState),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 153, 241, 156),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )))
            : Container(),
        const SizedBox(
          height: 50,
        ),



/* Image */
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50), // your margin
          child: SizedBox(
            height: 130,
            child: isBlack?const Image(image: AssetImage('assets/home_image.png'), color:Colors.green,):
            const Image(image: AssetImage('assets/home_image.png'))
          ),
        ),

        const SizedBox(
          height: 30,
        ),

/* Title */
        SizedBox(
          width: displayWidth(context),
          child: Text(
            appHomeTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: isBlack?Colors.blue:primaryColor, fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),

        !homePageState.isLogin && youTubeShow && !homePageState.drawerIsOpen
            ? Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        height: 340 * factor,
                        width: 600 * factor,
                        //width: displayWidth(context) - 50,
                        //width: 200,
                        //  child: FittedBox(
                        //  fit: BoxFit.fill,
                        child: YoutubePlayer(
                          controller: _controller,
                          aspectRatio: 16 / 9,
                        ),
                      ))
                ],
              )
            : Container(),
        const SizedBox(
          height: 50,
        ),

        // trackingId!=""?
        //   TrackingDetailsScreen(trackingModel: trackingData):Container(),

        const SizedBox(height: 30),
        buildCompanyCards(factor),
        const SizedBox(height: 30),

/* Memberships */
// subscriptionsbuild(homePageState, context, memberships, membershipOnlyVisibles, factor),
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
                    style: TextStyle(
                        color: isBlack?Colors.white:Colors.black87,
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


Widget buildCompanyCards(double factor) {
  final List<Map<String, String>> companies = [
    {"name": "Correios", "image": "assets/logo_corre.png"},
    {"name": "Jadlog", "image": "assets/logo_jadlog.png"},
    {"name": "TNT", "image": "assets/logo_tn.png"},
    {"name": "Mercado Livre", "image": "assets/logo_mer.png"},
    {"name": "Amazon", "image": "assets/logo_ama.png"},
    {"name": "Shopee", "image": "assets/logo_shop.png"},
  ];

  return Column(
    children: [
      const SizedBox(height: 20),
      Text(
        partnerCompanyTitle,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 16,
        runSpacing: 16,
        children: companies.map((company) {
          return SizedBox(
            width: 150 * factor,
            child: Card(
              color: isBlack?const Color.fromARGB(255, 56, 142, 223):const Color.fromARGB(255, 252, 241, 140),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding( 
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 60,
                      child: Image.asset(
                        company["image"]!,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      company["name"]!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ],
  );
}
