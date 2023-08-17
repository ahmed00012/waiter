
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:waiter/constants/prefs_utils.dart';
import 'package:waiter/ui/screens/auth_screens/login.dart';
import 'package:waiter/ui/screens/home/home_screen.dart';
import 'package:waiter/ui/widgets/bottom_nav_bar.dart';
import 'constants/colors.dart';
import 'local_storage.dart';




final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext ?context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main()async{

 WidgetsFlutterBinding.ensureInitialized();
 await LocalStorage.init();
 await EasyLocalization.ensureInitialized();
 HttpOverrides.global = new MyHttpOverrides();

  runApp(ProviderScope(child:  EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MyApp())));
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // GetData allData = GetData();




  // getBase()async{
  //
  //   bool result = await InternetConnectionChecker().hasConnection;
  //   if(result == true) {
  //     setState(() {
  //       LocalStorage.saveData(key: 'baseUrl', value: 'https://beta2.poss.app/api/');
  //     });
  //   }
  //
  //    else {
  //     setState(() {
  //       LocalStorage.saveData(key: 'baseUrl', value: 'http://192.168.1.11:8000/api/');
  //
  //     });
  //   }
  //
  // }

  // clearLocalStorage()async{
  //   if (LocalStorage.getData(key: 'firstRun') ?? true) {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     await preferences.clear();
  //     LocalStorage.saveData(key: 'first_run', value: false);
  //   }
  // }

  // @override
  // void initState() {
  //   // clearLocalStorage();
  //   // TODO: implement initState
  //   LocalStorage.saveData(key: 'baseUrl', value: 'https://beta2.poss.app/api/');
  //     getBase();
  //   if(LocalStorage.getData(key: 'token')!=null){
  //     allData.getAll();
  //   }
  //
  //
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      setLanguage(context.locale.languageCode);
        return OverlaySupport.global(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            navigatorKey: navigatorKey,
            // initialRoute: '/',
            // routes: {
            //  '/':(context) => Home(),
            // },
            theme: ThemeData(
               fontFamily: 'RobotoCondensed',
              scaffoldBackgroundColor: Constants.scaffoldColor,
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: Constants.mainColor,
                selectionColor: Constants.mainColor,
                selectionHandleColor:Constants.mainColor,
              ),
            ),
            home:  getUserToken().isNotEmpty ? Home() :Login(),
          ),
        );

  }
}


