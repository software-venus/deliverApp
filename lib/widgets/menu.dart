// ignore: import_of_legacy_library_into_null_safe
// ignore_for_file: deprecated_member_use

import 'package:entrega/models/parameter_model.dart';
import 'package:entrega/pages/content_view.dart';
import 'package:entrega/pages/flashcard_category_list.dart';
import 'package:entrega/pages/video_category_list.dart';
import 'package:entrega/pages/video_list.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:entrega/pages/home.dart';
import 'package:entrega/pages/membership_list.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:entrega/pages/user_login.dart';
import 'package:entrega/utils/general/reference_Page_State.dart';
import 'package:entrega/utils/list_transforms/parameter_list_transforms.dart';
import 'package:entrega/variables/globalvar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'package:translator/translator.dart';

// ignore: must_be_immutable
class Menu extends Drawer {
  Menu(
      {Key? key,
      required BuildContext context,
      required HomePageState homePageState})
      : super(
          key: key,
          elevation: 20,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _createHeader(),

                /* ABM List */
                homePageState.isLogin && homePageState.loginIsAdministrator
                    ? _createDrawerTitle(
                        text: menuABMListTitle, textColor: Colors.black54)
                    : Container(),

                /* Membership List */
                homePageState.isLogin && homePageState.loginIsAdministrator
                    ? createDrawerItem(
                        icon: Icons.card_membership_outlined,
                        text: menuProfilerAdministratorMembershipListTitle,
                        textColor: Colors.black,
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const MembershipList(),
                            ),
                          );
                        },
                      )
                    : Container(),

                /* Flashcard Category List */
                homePageState.isLogin && homePageState.loginIsAdministrator
                    ? createDrawerItem(
                        icon: Icons.flash_on_outlined,
                        text: menuProfilerAdministratorFlashcardCategoryListTitle,
                        textColor: Colors.black,
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const FlashcardCategoryList(),
                            ),
                          );
                        },
                      )
                    : Container(),

                /* Video List */
                homePageState.isLogin && homePageState.loginIsAdministrator
                    ? createDrawerItem(
                        icon: Icons.play_arrow_rounded,
                        text: menuProfilerAdministratorVideoListTitle,
                        textColor: Colors.black,
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const VideoList(),
                            ),
                          );
                        },
                      )
                    : Container(),

                /* Video Category List */
                homePageState.isLogin && homePageState.loginIsAdministrator
                    ? createDrawerItem(
                        icon: Icons.play_arrow_rounded,
                        text: menuProfilerAdministratorVideoCategoryListTitle,
                        textColor: Colors.black,
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const VideoCategoryList(),
                            ),
                          );
                        },
                      )
                    : Container(),

                /* Parameter List */
                homePageState.isLogin && homePageState.loginIsAdministrator
                    ? createDrawerItem(
                        icon: Icons.panorama_horizontal_select_outlined,
                        text: menuParameterTitle,
                        textColor: Colors.black,
                        onTap: () {
                          Navigator.pushNamed(context, "/ParameterList");
                        },
                      )
                    : Container(),

                /* Customer */
                _createDrawerTitle(
                    text: menuProfilerCustomerListTitle,
                    textColor: Colors.black54),

                /* Customer About Us */
                createDrawerImageItem(
                  icon: "assets/icons/info.png",
                  text: menuProfilerCustomerAboutUsTitle,
                  textColor: Colors.black,
                  onTap: () async {
                    ParameterModel parameterModel =
                        parameterStringFromKey2ToParameterModel(
                            homePageState.listParameters, "CustomerAboutUs");
                    String enContent =
                        await getTranslatedDetail(parameterModel.additional, languageStatus);
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ContentView(
                            title: menuProfilerCustomerAboutUsTitle,
                            body: enContent,
                            isFooterPayment: false),
                      ),
                    );
                  },
                ),

                /* Customer Frequent Questions */
                createDrawerImageItem(
                  icon: "assets/icons/faq.png",
                  text: menuProfilerCustomerFrequentQuestionsTitle,
                  textColor: Colors.black,
                  onTap: () {
                    ParameterModel parameterModel =
                        parameterStringFromKey2ToParameterModel(
                            homePageState.listParameters,
                            "CustomerFrequentQuestions");
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ContentView(
                            title: menuProfilerCustomerFrequentQuestionsTitle,
                            body: languageStatus == 0
                                ? parameterModel.additional
                                : parameterModel.additionalEn,
                            isFooterPayment: false),
                      ),
                    );
                  },
                ),

                /* Subscriptions */
                createDrawerImageItem(
                  icon: "assets/icons/money.png",
                  text: menuSubscriptionTitle,
                  textColor: Colors.black,
                  onTap: () {
                    ParameterModel parameterModel =
                        parameterStringFromKey2ToParameterModel(
                            homePageState.listParameters,
                            "CustomerFrequentQuestions");
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ContentView(
                            title: menuProfilerCustomerFrequentQuestionsTitle,
                            body: languageStatus == 0
                                ? parameterModel.additional
                                : parameterModel.additionalEn,
                            isFooterPayment: false),
                      ),
                    );
                  },
                ),

                createDrawerImageItem(
                  icon: "assets/icons/settings.png",
                  text: menuSettingsTitle,
                  textColor: Colors.black,
                  onTap: () {
                    ParameterModel parameterModel =
                        parameterStringFromKey2ToParameterModel(
                            homePageState.listParameters,
                            "CustomerFrequentQuestions");
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ContentView(
                            title: menuProfilerCustomerFrequentQuestionsTitle,
                            body: languageStatus == 0
                                ? parameterModel.additional
                                : parameterModel.additionalEn,
                            isFooterPayment: false),
                      ),
                    );
                  },
                ),

                /* CPanel */
                const Divider(),
                _createDrawerTitle(
                    text: menuCPanelTitle, textColor: Colors.black54),
                homePageState.isLogin
                    ? createDrawerItem(
                        icon: Icons.login_rounded,
                        text: homePageState.loginUsername,
                        textColor: Colors.black,
                      )
                    : Container(),

                !homePageState.isLogin
                    ? createDrawerItem(
                        icon: Icons.login_rounded,
                        text: menuCPanelUserLoginTitle,
                        textColor: Colors.black,
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => UserLogin(
                                  homePageState: homePageState,
                                  dobleClosed: true),
                            ),
                          );
                        },
                      )
                    : Container(),
                homePageState.isLogin &&
                        (homePageState.loginCanListUsers ||
                            homePageState.loginUsername
                                    .trim()
                                    .compareTo("joseluisocleppo@hotmail.com") ==
                                0)
                    ? createDrawerItem(
                        icon: Icons.people_rounded,
                        text: menuCPanelUserListTitle,
                        textColor: Colors.black,
                        onTap: () {
                          Navigator.pushNamed(context, "/UserList");
                        },
                      )
                    : Container(),
                !homePageState.isLogin
                    ? createDrawerItem(
                        icon: Icons.vpn_key_rounded,
                        text: menuCPanelUserLostPasswordTitle,
                        textColor: Colors.black,
                        onTap: () {
                          Navigator.pushNamed(context, "/UserLostPassword");
                        },
                      )
                    : Container(),
                homePageState.isLogin
                    ? createDrawerItem(
                        icon: Icons.logout_rounded,
                        text: menuCPanelUserLogoutTitle,
                        textColor: Colors.red.shade700,
                        onTap: () {
                          _userLogout(context, homePageState);
                        })
                    : Container(),
                const Divider(),
                // homePageState.isLogin
                //     ? createDrawerItem(
                //         icon: Icons.no_accounts_rounded,
                //         text: menuCPanelUserDeleteTitle,
                //         textColor: Colors.red,
                //         onTap: () {
                //           ShowDialogYesNo showDialogYesNo = ShowDialogYesNo(
                //               onClickYes: () {
                //                 ShowDialogOk showDialogOk = ShowDialogOk();
                //                 showDialogOk.show(
                //                     context, userDeletedTitle, userDeletedBody);
                //               },
                //               onClickNo: () {});
                //           showDialogYesNo.show(
                //               context,
                //               userDeleteTitle,
                //               userDeleteQuestion,
                //               userDeleteYesCaption,
                //               userDeleteNoCaption);
                //         })
                //     : Container(),
                const Divider(),
                createDrawerImageItem(
                  icon: "assets/icons/language.png",
                  text: menuLanguageTitle,
                  textColor: Colors.black,
                  onTap: () {},
                ),
                const Center(child: LanguageSwitcherButton()),
                const Divider(),
              ],
            ),
        );
}


Future<String> getTranslatedDetail(String text, int languageStatus) async {
    final translator = GoogleTranslator();
    return languageStatus == 0
        ? text
        : await translator.translate(text, to: "en").then((t) => t.text);
}

Widget _createHeader() {
  return const DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/menuhead.png'))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("TODO LUGAR TODA ENTREGA",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]
      )
      );
}

Widget _createDrawerTitle({required String text, required Color textColor}) {
  return ListTile(
      title: Row(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(text, style: TextStyle(fontSize: 20, color: textColor)),
      )
    ],
  ));
}

Widget createDrawerItem(
    {required IconData icon,
    required String text,
    required Color textColor,
    GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(text,
              style: TextStyle(
                color: textColor,
              )),
        )
      ],
    ),
    onTap: onTap,
  );
}

Widget createDrawerImageItem(
    {required String icon,
    required String text,
    required Color textColor,
    GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Image.asset(
          icon,
          width: 22,
          height: 22,
          fit: BoxFit.contain,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(text,
              style: TextStyle(
                color: textColor,
              )),
        )
      ],
    ),
    onTap: onTap,
  );
}

Future<void> _userLogout(
    BuildContext context, HomePageState homePageState) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(preferenceIsLogin, false);
  prefs.setString(preferenceLoginUsername, "");

  homePageState.setIsLogin(false);
  homePageState.setLoginUsername("");
  homePageState.setLoginCanListUsers(false);
  homePageState.setLoginIsAdministrator(false);
  homePageState.setLoginIsCustomer(false);

//  homePageState.isNewImage1 = false;
//  homePageState.isNewImage2 = false;

  Navigator.pop(context);

  homePageState.refresh();
}

class MenuReferencePageState extends ReferencePageState {
  HomePageState homePageState;

  MenuReferencePageState(this.homePageState);

  @override
  void setStates() {
    // ignore: invalid_use_of_protected_member
    homePageState.setState(() {});
  }
  
}

class LanguageSwitcherButton extends StatefulWidget {
  const LanguageSwitcherButton({super.key});

  @override
  State<LanguageSwitcherButton> createState() => _LanguageSwitcherButtonState();
}

class _LanguageSwitcherButtonState extends State<LanguageSwitcherButton> {
  bool isEnglish = true;

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference();
  }

  Future<void> _loadLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('language_code') ?? 'en';
    setState(() {
      isEnglish = langCode == "en";
    });
  }

  Future<void> _toggleLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isEnglish = !isEnglish;
    });

    final newLocale = isEnglish ? const Locale('en') : const Locale('es');
    await prefs.setString('language_code', newLocale.languageCode);

    languageStatus = newLocale.languageCode=="es"?0:1;

    App.setLocale(context, newLocale);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isEnglish ? 'Language switched to English' : 'Idioma cambiado a Español',
        ),
        duration: const Duration(seconds: 2),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleLanguage,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          isEnglish ? 'assets/spt.png' : 'assets/english.png',
          width: 80,
          height: 40,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
