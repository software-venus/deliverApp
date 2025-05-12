// ignore_for_file: prefer_const_constructors, deprecated_member_use, library_prefixes, unnecessary_null_comparison, equal_elements_in_set
// ignore: import_of_legacy_library_into_null_safe, unused_import
import 'dart:convert';
// import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:entrega/models/event_model.dart';
import 'package:entrega/models/membership_model.dart';
import 'package:entrega/models/recipient_model.dart';
import 'package:entrega/models/timestamps.dart';
import 'package:entrega/models/tracker_model.dart';
import 'package:entrega/models/tracking_model.dart';
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
import 'package:entrega/utils/firebase/firebase_track.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entrega/widgets/customer_build.dart';
import 'package:entrega/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:entrega/variables/globalvar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:entrega/widgets/tracking_build.dart';
// import 'package:entrega/utils/firebase/firebase_track.dart';

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
  bool isLoading = false;
  String loginUsername = "";
  bool loginCanListUsers = false;
  bool loginIsAdministrator = false;
  bool loginIsCustomer = false;
  String loginCustomerName = "";

  bool positionPermissionDeny = false;

  bool drawerIsOpen = false;

  MembershipModel customerMembershipCurrent =
      MembershipModel(false, "", "", "", 0, 0, false, DateTime.now());

  List<ParameterModel> listParameters = [];
  List<MembershipModel> membershipLists = [];
  List<MembershipModel> membershipOnlyVisibleLists = [];
  TrackerModel tracker = TrackerModel("", "", "", "", [], "", null, null, null);
  List<EventModel> events = [];
  RecipientModel recipient = RecipientModel("", "", "", "", "", "");
  TimeStampsModel timeStamps =
      TimeStampsModel("", null, null, null, null, null, null, null);
  TrackingModel trackingData = TrackingModel(
      trackingId,
      "",
      TrackerModel("", "", "", "", [], "", null, null, null),
      RecipientModel("", "", "", "", "", ""),
      [],
      TimeStampsModel("", null, null, null, null, null, null, null));

  var trackData = {};

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
    shopeeTracking(trackingId);
  }

  Future<void> shopeeTracking(String trackingId) async {
    setState(() => isLoading = true);

  await Future.delayed(const Duration(seconds: 1)); // <-- 2-second delay

  for (var i = 0; i < listParameters.length; i++) {
    if (listParameters[i].key2 == "shopeeApiKey" && trackingId == "S24DEMO456395") {
      final url = Uri.parse(
          'https://api.ship24.com/public/v1/trackers/search/$trackingId/results');

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${listParameters[i].additional}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        trackData = data['data']['trackings'][0];
        print('✅ Tracking data: $data');
        recipient = RecipientModel.fromJSON(
            trackingId, trackData['shipment']['recipient']);
        tracker = TrackerModel.fromJSON(trackingId, trackData['tracker']);
        timeStamps = TimeStampsModel.fromJSON(
            trackingId, trackData['statistics']['timestamps']);

        if (trackData['events'].isNotEmpty) {
          for (var i = 0; i < trackData['events'].length; i++) {
            events.add(EventModel.fromJSON(trackData['events'][i]));
          }
        }

        setState(() {
          trackData["username"] = loginUsername;
          trackingData = TrackingModel(
              trackingId, "shopee", tracker, recipient, events, timeStamps);
        });

        print("===================${trackingData.tracker.trackerId}===============");
      } else {
        setState(() {
          trackData = {};
          trackingData = TrackingModel(
              trackingId,
              "",
              TrackerModel("", "", "", "", [], "", null, null, null),
              RecipientModel("", "", "", "", "", ""),
              [],
              TimeStampsModel("", null, null, null, null, null, null, null));
          tracker = TrackerModel("", "", "", "", [], "", null, null, null);
          events = [];
          recipient = RecipientModel("", "", "", "", "", "");
          timeStamps = TimeStampsModel("", null, null, null, null, null, null, null);
        });

        final errorData = json.decode(response.body);
        final errorMessage = errorData['errors'][0]['message'].toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        );
        print('❌ Failed: ${response.statusCode} - ${response.body}');
      }
    }
  }

  if (trackingId == "TBA288936836275") {
    recipient = RecipientModel(trackingId, "jone", "CA", "1234", "LOS", "");
    tracker = TrackerModel(trackingId, "r34e4-2r2r3-rr4r2-yy45y", trackingId, "", [], "", true, true, DateTime.now());
    timeStamps = TimeStampsModel(trackingId, null, null, null, null, null, null, null);
    events = [];

    setState(() {
      trackData["username"] = loginUsername;
      trackingData = TrackingModel(
          trackingId, "Amazon", tracker, recipient, events, timeStamps);
    });
  }

  if (trackingId == "MLB1234863940") {
    recipient = RecipientModel(trackingId, "Dane", "CA", "1234", "LOS", "");
    tracker = TrackerModel(trackingId, "s898wk80897968968shhefi808", trackingId, "", [], "", true, true, DateTime.now());
    timeStamps = TimeStampsModel(trackingId, null, null, null, null, null, null, null);
    events = [];

    setState(() {
      trackData["username"] = loginUsername;
      trackingData = TrackingModel(
          trackingId, "Mercado", tracker, recipient, events, timeStamps);
    });
  }

  if (trackingId == "449044304137821") {
    recipient = RecipientModel(trackingId, "Jhon", "CA", "1234", "LOS", "");
    tracker = TrackerModel(trackingId, "4i0jw0fujjljs8e8983fj98f34f3t3", trackingId, "", [], "", true, true, DateTime.now());
    timeStamps = TimeStampsModel(trackingId, null, null, null, null, null, null, null);
    events = [];

    setState(() {
      trackData["username"] = loginUsername;
      trackingData = TrackingModel(
          trackingId, "TNT", tracker, recipient, events, timeStamps);
    });
  }

  if (trackingId == "69200787401536") {
    recipient = RecipientModel(trackingId, "Lock", "CA", "1234", "LOS", "");
    tracker = TrackerModel(trackingId, "j578-rur5-jobn-2869-3", trackingId, "", [], "", true, true, DateTime.now());
    timeStamps = TimeStampsModel(trackingId, null, null, null, null, null, null, null);
    events = [];

    setState(() {
      trackData["username"] = loginUsername;
      trackingData = TrackingModel(
          trackingId, "Jadlog", tracker, recipient, events, timeStamps);
    });
  }

  if (trackingId == "LB123456789BR") {
    recipient = RecipientModel(trackingId, "Lee", "CA", "1234", "LOS", "");
    tracker = TrackerModel(trackingId, "sef8jf0kakjjvoif98296274", trackingId, "", [], "", true, true, DateTime.now());
    timeStamps = TimeStampsModel(trackingId, null, null, null, null, null, null, null);
    events = [];

    setState(() {
      trackData["username"] = loginUsername;
      trackingData = TrackingModel(
          trackingId, "Correios", tracker, recipient, events, timeStamps);
    });
  }

  if (trackingId == "AM336979313BR") {
    events = [EventModel(trackingId, null, "", "", DateTime(2025, 4, 28, 9, 58), null, "By the Distribution Unit, Montes Claros - MG", null, null, "Object delivered to recipient", null),
              EventModel(trackingId, null, "", "There must be someone at the address to receive the mail", DateTime(2025, 4, 28, 8, 4), null, "Montes Claros - MG", null, null, "Object left for delivery to the recipient", null),
              EventModel(trackingId, null, "", "for Distribution Unit, Montes Claros - MG", DateTime(2025, 4, 25, 21, 56), null, "Treatment Unit, Belo Horizonte - MG", null, null, "Object being transferred - please wait", null),
              EventModel(trackingId, null, "", "for Treatment Unit, Belo Horizonte - MG", DateTime(2025, 4, 23, 22, 23), null, "from Treatment Unit, Curitiba - PR", null, null, "Object being transferred - please wait", null),
              EventModel(trackingId, null, "", "We have identified the error and your item will be forwarded shortly.", DateTime(2025, 4, 23, 22, 23), null, "Curitiba - PR", null, null, "Object in route correction", null),
              EventModel(trackingId, null, "", "for Treatment Unit, Sao Jose - SC", DateTime(2025, 4, 22, 16, 07), null, "from the Post Office, Blumenau - SC", null, null, "Object being transferred - please wait", null),
              EventModel(trackingId, null, "", "", DateTime(2025, 4, 22, 16, 07), null, "Blumenau - SC", null, null, "Object posted", null),
              EventModel(trackingId, null, "", "Waiting for post by sender", DateTime(2025, 4, 22, 13, 13), null, "BR", null, null, "Label issued", null),
                            ];
    recipient = RecipientModel(trackingId, "", "Montes Claros - MG", "", "", "");
    tracker = TrackerModel(trackingId, "EFTW-8JUPM-U98H-DRD7-JUW7", trackingId, "", [], "", true, true, DateTime(2025, 4, 22, 13, 13));
    timeStamps = TimeStampsModel(trackingId, null, null, null, null, null, null, null);

    setState(() {
      trackData["username"] = loginUsername;
      trackingData = TrackingModel(
          trackingId, "Correios", tracker, recipient, events, timeStamps);
    });
  }

  setState(() => isLoading = false);
}


  void startTracking(TrackingModel trackingModel) async {
    setState(() {
      trackData["username"] = loginUsername;
      trackData["trackingNumber"] = trackingId;
      trackData["company"] = trackingModel.company;
    });

    final firestoreInstance = FirebaseFirestore.instance;
    final CollectionReference tracks =
        firestoreInstance.collection(firebaseTracksKey);

    // Step 1: Count documents for this user
    final querySnapshot =
        await tracks.where('username', isEqualTo: loginUsername).get();

    final int currentTrackCount = querySnapshot.docs.length;

    // Step 2: Compare with allowed max
    if (currentTrackCount >= customerMembershipCurrent.maxTracks) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please upgrade membership",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
      return; // Exit early, do not add
    }

    FirebaseTracksHelper().add(trackData).then((result) {
      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "tracks saved successfully",
            style: const TextStyle(fontSize: 16),
          ),
        ));
        // Navigator.pop(context);
        // widget.parameterListState
        //     .refreshList();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            result,
            style: const TextStyle(fontSize: 16),
          ),
        ));
      }
    });
    print("======================${trackData}=========================");
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

        if (loginIsAdministrator) {}

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

    if (loginIsAdministrator) {}

    if (loginIsCustomer) {
      loadCustomer();
    }
  }

  globalRefresh() {
    if (loginIsAdministrator) {}

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
          body: isLoading?const Center(child: CircularProgressIndicator()):trackingId.isEmpty
              ? customerBuild(this, context, membershipLists,
                  membershipOnlyVisibleLists, factor(context), trackingData)
              : TrackingDetailsScreen(
                  trackingModel: trackingData,
                  homePageState: this,
                  startTracking: startTracking,
                ));
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
          body: isLoading?const Center(child: CircularProgressIndicator()):trackingId.isEmpty
              ? customerBuild(this, context, membershipLists,
                  membershipOnlyVisibleLists, factor(context), trackingData)
              : TrackingDetailsScreen(
                  trackingModel: trackingData,
                  homePageState: this,
                  startTracking: startTracking,
                ));
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
