import 'package:flutter/material.dart';

import 'landingpage.dart';
import 'chooseplan.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initOneSignal();
  runApp(MyApp());
}

/// OneSignal Initialization
void initOneSignal() async {
  // setting up push notification with onesignal
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.init("e5e7bbef-166f-4146-b07c-ce1c8354d091", iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

  // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metrohyp Services',
      theme: ThemeData(
          // primarySwatch: Colors.yellow[800],
          // backgroundColor: Colors.white,
          ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => new LandingPage(),
        '/chooseplan': (BuildContext context) => new ChoosePlan(),
      },
      initialRoute: '/',
    );
  }
}
