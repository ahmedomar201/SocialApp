import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/bloc_observer.dart';
import 'package:socialapp/firebase_options.dart';
import 'package:socialapp/layout/cubit.dart';
import 'package:socialapp/layout/social_layout.dart';
import 'package:socialapp/layout/states.dart';
import 'package:socialapp/modules/login/login_screen.dart';
import 'package:socialapp/shared/styles/theme.dart';
import 'shared/componets/tasks.dart';
import 'shared/netwoark/local/cash_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  uId = CacheHelper.getData(key: "uId");
  Widget widget;
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  late final Widget startWidget;

  //required this.isDark
  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()..getUserModel(),
      child: BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) => MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                //themeMode: ThemeMode.dark,
                home: SocialLayout(),
              )),
    );
  }
}
