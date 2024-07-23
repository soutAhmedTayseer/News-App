import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/BusinessScreen.dart';
import 'package:flutter_projects/ScienceScreen.dart';
import 'package:flutter_projects/SettingsScreen.dart';
import 'package:flutter_projects/SportsScreen.dart';
import 'states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.business_center),label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports),label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science),label: 'Science'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),

  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    const SettingsScreen(),

  ];
  void changeBottomBottomNavBar(int index){
    currentIndex = index;
    emit(NewsBottomNavState());
  }
}
