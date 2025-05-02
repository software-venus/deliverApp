import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:entrega/pages/home.dart';
import 'package:entrega/pages/parameter_list.dart';
import 'package:entrega/pages/payment_cancel.dart';
import 'package:entrega/pages/payment_confirm.dart';
import 'package:entrega/pages/payment_paypal_confirm.dart';
import 'package:entrega/pages/tos.dart';
import 'package:entrega/pages/user_list.dart';
import 'package:entrega/pages/user_lostpassword.dart';
import 'package:entrega/pages/wb_payment_cancel.dart';
import 'package:entrega/pages/wb_payment_confirm.dart';
import 'package:entrega/utils/general/sizes_helpers.dart';
import 'package:entrega/variables/globalvar.dart';

// 👇 Generated localization file (after flutter gen-l10n)
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

DateTime defaultDateTime = DateTime.utc(1969, 7, 20, 20, 18, 04);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (isWeb()) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey : "AIzaSyDy-wZBBYCQPeytgBPjL6ZtI6tsOvto09E" , 
        authDomain : "delivertrackapp.firebaseapp.com" , 
        projectId : "delivertrackapp" , 
        storageBucket : "delivertrackapp.firebasestorage.app" , 
        messagingSenderId : "443709792692" , 
        appId : "1:443709792692:web:3b8d76ffb2d2e1bfc152e1" , 
        measurementId : "G-SEB02BM0PJ" 
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const App());
}

// Stateful app so we can change Locale dynamically
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    final _AppState? state = context.findAncestorStateOfType<_AppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('language_code');
    if (langCode != null) {
      setState(() {
        _locale = Locale(langCode);
        languageStatus = langCode=="es"?0:1;
      });
    }
  }

  void setLocale(Locale locale) async {
    setState(() {
      _locale = locale;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(primarySwatch: Colors.blue),
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: generateRoute,
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    String path;
    QueryParameters queryParameters = QueryParameters();

    if (!settings.name!.contains("?")) {
      path = settings.name!;
    } else {
      path = settings.name!.split("?")[0];
      for (String value in settings.name!.split("?")[1].split("&")) {
        List<String> tPart = value.split("=");
        queryParameters.add(tPart[0], tPart[1]);
      }
    }

    switch (path) {
      case "/payment_paypal_success":
        return MaterialPageRoute(
          builder: (context) =>
              PaymentPayPalConfirm(queryParameters: queryParameters),
          settings: settings,
        );

      case "/payment_success":
        return MaterialPageRoute(
          builder: (context) =>
              PaymentConfirm(queryParameters: queryParameters),
          settings: settings,
        );

      case "/payment_cancel":
        return MaterialPageRoute(
          builder: (context) =>
              PaymentCancel(queryParameters: queryParameters),
          settings: settings,
        );

      case "/wb_payment_success":
        return MaterialPageRoute(
          builder: (context) =>
              WBPaymentConfirm(queryParameters: queryParameters),
          settings: settings,
        );

      case "/wb_payment_cancel":
        return MaterialPageRoute(
          builder: (context) =>
              WBPaymentCancel(queryParameters: queryParameters),
          settings: settings,
        );

      case "/UserLostPassword":
        return MaterialPageRoute(
          builder: (context) => const UserLostPassword(),
          settings: settings,
        );

      case "/UserList":
        return MaterialPageRoute(
          builder: (context) => const UserList(),
          settings: settings,
        );

      case "/ParameterList":
        return MaterialPageRoute(
          builder: (context) => const ParameterList(),
          settings: settings,
        );

      case "/Tos":
        return MaterialPageRoute(
          builder: (context) => const Tos(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => HomePage(idProfiler: IdProfiler.general),
          settings: settings,
        );
    }
  }
}

// Query Parameter Classes (same as your original)
class QueryParameter {
  String key;
  String value;

  QueryParameter(this.key, this.value);
}

class QueryParameters {
  List<QueryParameter> queryParameters = [];

  void add(String key, String value) {
    queryParameters.add(QueryParameter(key, value));
  }

  String getValue(String key) {
    for (QueryParameter queryParameter in queryParameters) {
      if (queryParameter.key == key) {
        return queryParameter.value;
      }
    }
    return "";
  }
}
