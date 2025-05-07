// ignore_for_file: prefer_const_constructors, deprecated_member_use, library_prefixes, unnecessary_null_comparison
// ignore: import_of_legacy_library_into_null_safe, unused_import
import 'dart:convert';
// import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:entrega/models/membership_model.dart';
import 'package:entrega/widgets/application_bar_customer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:entrega/models/parameter_model.dart';
import 'package:entrega/models/user_model.dart';
// ignore: unused_import
import 'package:entrega/utils/general/reference_Page_State.dart';
import 'package:entrega/utils/general/sizes_helpers.dart';
import 'package:entrega/utils/list_transforms/parameter_list_transforms.dart'
    as parameterTransforms;
import 'package:entrega/utils/list_transforms/membership_list_transforms.dart'
    as membershipTransforms;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entrega/widgets/customer_build.dart';
import 'package:entrega/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:entrega/variables/globalvar.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum IdProfiler { undefined, general, customer }


// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  IdProfiler idProfiler;

  HomePage({Key? key, required this.idProfiler}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  IdProfiler idProfiler = IdProfiler.undefined;

  bool isLogin = false;
  String loginUsername = "";
  bool loginCanListUsers = false;
  bool loginIsAdministrator = false;
  bool loginIsCustomer = false;
  String loginCustomerName = "";

  bool positionPermissionDeny = false;

  bool drawerIsOpen = false;


  MembershipModel customerMembershipCurrent = MembershipModel(
      false, "", "", "", 0, 0, false, DateTime.now());

  List<ParameterModel> listParameters = [];
  List<MembershipModel> membershipLists = [];
  List<MembershipModel> membershipOnlyVisibleLists = [];

  void setIsLogin(bool isLogin) {
    this.isLogin = isLogin;
  }

  void setLoginUsername(String loginUsername) {
    this.loginUsername = loginUsername;
  }

  void setLoginCanListUsers(bool loginCanListUsers) {
    this.loginCanListUsers = loginCanListUsers;
  }

  void setLoginIsAdministrator(bool loginIsAdministrator) {
    this.loginIsAdministrator = loginIsAdministrator;
  }

  void setLoginIsCustomer(bool loginIsCustomer) {
    this.loginIsCustomer = loginIsCustomer;
  }

  

//  late VideoPlayerController videoPlayercontroller;

  @override
  void initState() {
    super.initState();

    idProfiler = widget.idProfiler;

    refresh();
  }

  void setStates() {
    setState(() {});
  }

  void updateTrackingId(String newTrackingId) {
    setState(() {
      trackingId = newTrackingId;
    });
  }

  Future<void> loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? resultIsLogin = prefs.getBool(preferenceIsLogin);
    String? resultLoginUsername = prefs.getString(preferenceLoginUsername);

    if (resultIsLogin != null) {
      isLogin = resultIsLogin;
    }

    if (resultLoginUsername != null) {
      loginUsername = resultLoginUsername;
    }

    loadCommons();

    if (isLogin) {
      final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
      CollectionReference appUsers =
          firestoreInstance.collection(firebaseCustomUserKey);

      appUsers.doc(resultLoginUsername).get().then((result) async {
        UserModel userModel = UserModel.fromJSON(result.id, result.data());

        loginCanListUsers = userModel.canListUsers;
        loginIsAdministrator = userModel.isAdministrator;
        loginIsCustomer = userModel.isCustomer;
        loginCustomerName = userModel.name;

        if (loginIsAdministrator) {

        }

        if (loginIsCustomer) {
          loadCustomer();
        }

        setState(() {});
      });
    } else {
      setState(() {});
    }
  }

  Future<void> loadCommons() async {
    try {
      listParameters.clear();

      final firestoreInstance = FirebaseFirestore.instance;

      CollectionReference parameters =
          firestoreInstance.collection(firebaseCustomParameterKey);

      parameters.orderBy("title").get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          setState(() {
            parameterTransforms.uniquedAdd(listParameters,
                ParameterModel.fromJSON(false, result.id, result.data()));
          });
        }
      });

      setState(() {});

      // Memberships
      membershipLists.clear();
      membershipOnlyVisibleLists.clear();

      CollectionReference memberships =
          firestoreInstance.collection(firebaseCustomMembershipKey);

      memberships
          .limit(100)
          .orderBy("price", descending: false)
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          setState(() {
            MembershipModel newMembership =
                MembershipModel.fromJSON(false, result.id, result.data());
            membershipTransforms.uniquedAdd(membershipLists, newMembership);


            membershipTransforms.uniquedAdd(
                membershipOnlyVisibleLists, newMembership);
          });
        }
      });

      setState(() {});
    } on FirebaseAuthException catch (e) {
      e.stackTrace;
    }
  }

  Future<void> loadCustomer() async {
    try {
      final firestoreInstance = FirebaseFirestore.instance;

      // Customer Membership Current
      if (loginUsername.isNotEmpty) {
        CollectionReference appUserMemberships =
            firestoreInstance.collection(firebaseCustomUserMembershipKey);
        DocumentSnapshot documentSnapshot =
            await appUserMemberships.doc(loginUsername).get();
        customerMembershipCurrent = MembershipModel.fromJSON(
            false, documentSnapshot.id, documentSnapshot.data());
      }

      // Customer Category


      setState(() {});
    } on FirebaseAuthException catch (e) {
      e.stackTrace;
    }
  }

  refresh() {
    loadPreferences();

    if (loginIsAdministrator) {

    }

    if (loginIsCustomer) {
      loadCustomer();
    }
  }

  globalRefresh() {
    if (loginIsAdministrator) {

    }

    if (loginIsCustomer) {
      loadCustomer();
    }
  }

  // ignore: unused_field
  int _currentIndex = 0;
  final List _children = [];

  void setCurrentIndex(int currentIndex) {
    _currentIndex = currentIndex;
  }


  @override
  Widget build(BuildContext context) {
    _children.clear();

/* Not Login */
    if (!isLogin) {
      return Scaffold(
          appBar: ApplicationBarCustomer(
            title: appName,
            backgroundColor: customBackcolor,
            context: context,
            withShareButton: false,
            homePageState: this,
            updateTrackingId: updateTrackingId,
          ),
          drawer: Menu(
            context: context,
            homePageState: this,
          ),
          onDrawerChanged: (isOpen) {
            setState(() {
              drawerIsOpen = isOpen;
            });
          },
          body: customerBuild(
              this,
              context,
              membershipLists,
              membershipOnlyVisibleLists,
              factor(context)));
    }

/* Is Administrator */
    if (isLogin && loginIsAdministrator) {
      return Scaffold(
          appBar: AppBar(
            title: const Text(appName),
            backgroundColor: primaryColor,
          ),
          drawer: Menu(
            context: context,
            homePageState: this,
          ),
          body: Container());
    }

/* Is Customer */
    if (isLogin && loginIsCustomer) {
      return Scaffold(
          appBar: ApplicationBarCustomer(
            context: context,
            title: "",
            backgroundColor: primaryColor,
            withRefreshWeb: false,
            homePageState: this,
            updateTrackingId: updateTrackingId,
          ),
          drawer: Menu(
            context: context,
            homePageState: this,
          ),
          body: customerBuild(
              this,
              context,
              membershipLists,
              membershipOnlyVisibleLists,
              factor(context),));
    }

/*  Default Screen */
    return Scaffold(
        appBar: AppBar(
          title: const Text(""),
          backgroundColor: customBackcolor,
        ),
        drawer: Menu(
          context: context,
          homePageState: this,
        ),
        body: Container());
  }

  double getDisplayWidth() {
    return displayWidth(context);
  }

  double getDisplayHeight() {
    return displayHeight(context);
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class HomeReferencePageState extends ReferencePageState {
  HomePageState homePageState;

  HomeReferencePageState(this.homePageState);

  @override
  void setStates() {
    // ignore: invalid_use_of_protected_member
    homePageState.setState(() {});
  }
}

class TimeSeriesSales {
  String key;
  DateTime time;
  double sales;
  int count;

  TimeSeriesSales(this.key, this.time, this.sales, this.count);
}
