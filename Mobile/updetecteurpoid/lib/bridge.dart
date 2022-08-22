import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updetecteurpoid/screens/app/home.dart';
import 'package:updetecteurpoid/screens/app/parametter.dart';
import 'package:updetecteurpoid/logic/bloc/app_bloc.dart';

class Bridge extends StatefulWidget {
  const Bridge({Key? key}) : super(key: key);

  @override
  State<Bridge> createState() => _BridgeState();
}

class _BridgeState extends State<Bridge> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Color(0xFFF5F5F5),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFFF5F5F5),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return BlocProvider(
      create: (_) => Appbloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        ),
        routes: {
          Setting.routeName: (context) => const Setting(),
        },
        home: const Home(),
      ),
    );
  }
}
