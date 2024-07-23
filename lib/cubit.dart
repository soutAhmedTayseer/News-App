import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/BusinessScreen.dart';
import 'package:flutter_projects/ScienceScreen.dart';
import 'package:flutter_projects/SettingsScreen.dart';
import 'package:flutter_projects/SportsScreen.dart';
import 'DioHelper.dart';
import 'states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business_center), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<String> titles = [
    'business',
    'sports',
    'science',
  ];
  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    const SettingsScreen(),
  ];

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': 'business',
      'from': '2024-06-23',
      'sortBy': 'publishedAt',
      'apiKey': '05bfb63b949e4c818ed3c2a99d3b3afc',
    }).then((value) {
      business = value.data['articles'];
      if (kDebugMode) {
        print(business[0]['description']);
      }
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());

    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/everything', query: {
        'q': 'sports',
        'from': '2024-06-23',
        'sortBy': 'publishedAt',
        'apiKey': '05bfb63b949e4c818ed3c2a99d3b3afc',
      }).then((value) {
        sports = value.data['articles'];
        if (kDebugMode) {
          print(sports[0]['description']);
        }
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/everything', query: {
        'q': 'science',
        'from': '2024-06-23',
        'sortBy': 'publishedAt',
        'apiKey': '05bfb63b949e4c818ed3c2a99d3b3afc',
      }).then((value) {
        science = value.data['articles'];
        if (kDebugMode) {
          print(science[0]['description']);
        }
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  void changeBottomBottomNavBar(int index) {
    currentIndex = index;
    if (index == 0) {
      getBusiness();
    }
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }
}
