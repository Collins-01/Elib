import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:elib/feature/onboarding/services/auth_services.dart';
import 'package:elib/helpers/components/app_icon.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/theme.dart';
import 'package:elib/screen_loader.dart';
import 'package:elib/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'eliby Tv',
          debugShowCheckedModeBanner: false,
          theme: elibTheme.lightTheme,
          home: FutureBuilder(
              future: AuthServices().checkIfAuth(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return PageLayout(
                    noAppBar: true,
                    navPop: false,
                    child: Container(
                        color: Colors.white, child: Center(child: AppIcon())),
                  );
                }

                return snapshot.data["token"] != null
                    ? ScreenLoader()
                    : WelcomeOnBoardingPage();
              }),
        );
      }
    );
  }
}
