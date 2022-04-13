// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/layouts/home/cubit/cubit.dart';
import 'package:flutter_auth/layouts/home/home_screen.dart';
import 'package:flutter_auth/modules/login/login_screen.dart';
import 'package:flutter_auth/modules/splash/splash_screen.dart';
import 'package:flutter_auth/shared/bloc_observe.dart';
import 'package:flutter_auth/shared/components/constants.dart';
import 'package:flutter_auth/shared/network/local/cache_helper.dart';
import 'package:flutter_auth/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  splash=CacheHelper.getData(key: 'splash');
  uId=CacheHelper.getData(key: 'uId');


  Widget widget;

  if (splash !=null){
    if(uId!=null){
    widget=HomeScreen();
  }else{
    widget=LoginScreen();
  }}else{
    widget=SplashScreen();
  }

  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        startWidget: widget,));

    },


    blocObserver: MyBlocObserver(),
  );



}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({ required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>HomeLayoutCubit()..getData(),
      child:MaterialApp(
      title: 'Flutter Demo',
      theme:orangeTheme,
        debugShowCheckedModeBanner: false,
        home:  startWidget,
    ),
    );
  }
}