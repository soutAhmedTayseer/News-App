import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/DioHelper.dart';
import 'package:flutter_projects/BusinessScreen.dart';
import 'package:flutter_projects/ScienceScreen.dart';
import 'package:flutter_projects/SportsScreen.dart';
import 'package:flutter_projects/states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;
  ThemeMode themeMode = ThemeMode.light;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business_center), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.health_and_safety), label: 'Health'),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  List<dynamic> business = [];
  List<dynamic> businessSearchResults = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': 'business',
      'from': '2024-08-4',
      'sortBy': 'publishedAt',
      'apiKey': '88241b388d4c4ed6939e73c72d6b84d5',
    }).then((value) {
      business = value.data['articles'];
      businessSearchResults = business; // Initialize with all
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void searchBusiness(String query) {
    if (query.isEmpty) {
      businessSearchResults = business;
    } else {
      businessSearchResults = business
          .where((article) =>
          article['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    emit(NewsGetBusinessSuccessState());
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/everything', query: {
        'q': 'sports',
        'from': '2024-08-4',
        'sortBy': 'publishedAt',
        'apiKey': '88241b388d4c4ed6939e73c72d6b84d5',
      }).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
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
        'q': 'health',
        'from': '2024-08-2',
        'sortBy': 'publishedAt',
        'apiKey': '88241b388d4c4ed6939e73c72d6b84d5',
      }).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  void changeBottomNavBar(int index) {
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

  void toggleTheme() async {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', themeMode == ThemeMode.dark);
    emit(ThemeChangedState());
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    emit(ThemeChangedState());
  }
}
