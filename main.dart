import 'package:flutter/material.dart';
import 'package:wallet_manager_ads_sharedpref/pages/HomePages.dart';
//import 'package:wallet_manager/pages/HomePage.dart';
import 'package:wallet_manager_ads_sharedpref/util/transInfo.dart';
import 'package:wallet_manager_ads_sharedpref/util/whallet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart'
    '';
final darkModeNotifier = ValueNotifier<bool>(false);
 bool opened=false;
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SharedPreferences pref=await SharedPreferences.getInstance();
  if((pref.getBool('opened'))!=null){
    opened=pref.getBool('opened')!;
  }else{opened=false;}

  //
  // RequestConfiguration config=RequestConfiguration(
  //   testDeviceIds: <String>["63EFE010D66091E746B5E56A8706A50F"],
  // );
  // //MobileAds.instance.initialize();
  // MobileAds.instance.updateRequestConfiguration(config);
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);
  const MyApp({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: darkModeNotifier,
        builder: (context, value, child) {
          return MaterialApp(
            theme: value ? ThemeData.dark() : ThemeData.light(),
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        home : HomePage(),
      );
    }

    );
  }
// Future<bool> getpref()async{
//     SharedPreferences pref=await SharedPreferences.getInstance();
//     if((pref.getBool('NightMood'))!=null){
//       return pref.getBool('NightMood')!;
//     }else{return false;}
//   }
}
