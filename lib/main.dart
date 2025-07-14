import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'firebase_options.dart';
import 'layout/cubit.dart';
import 'layout/social_layout.dart';
import 'layout/states.dart';
import 'modules/login/login_screen.dart';
import 'presentionLayer/screens/login_screen.dart';
import 'shared/componets/tasks.dart';
import 'shared/netwoark/local/cash_helper.dart';
import 'shared/styles/theme.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
  print(message.data.toString());
  showToast(text: 'on background message', state: ToastStates.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var token = await FirebaseMessaging.instance.getToken();
  print(token);

  // foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());

    showToast(text: 'on message', state: ToastStates.SUCCESS);
  });

  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());

    showToast(text: 'on message opened app', state: ToastStates.SUCCESS);
  });

  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  uId = CacheHelper.getData(key: "uId");
  Widget widget;
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  //required this.isDark
  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()
        ..getUserModel()
        ..getPosts(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          //themeMode: ThemeMode.dark,
          home: LoginScreen(),
        ),
      ),
    );
  }
}
  //restApi:https://fcm.googleapis.com/fcm/send