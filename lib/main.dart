import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/DioHelper.dart';
import 'package:flutter_projects/SplashScreen.dart';
import 'package:flutter_projects/cubit.dart';
import 'package:flutter_projects/states.dart';
import 'themes.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..loadTheme()
        ..getBusiness()
        ..getSports()
        ..getScience(),
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          var themeMode = AppCubit.get(context).themeMode;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            home: const Directionality(
              textDirection: TextDirection.ltr,
              child: SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
