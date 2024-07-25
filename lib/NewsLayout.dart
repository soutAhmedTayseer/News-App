import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/cubit.dart';
import 'package:flutter_projects/states.dart';

import 'BuildArticleItem.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(
                onPressed: () {
                  // Show a search field
                  showSearch(
                    context: context,
                    delegate: ArticleSearchDelegate(cubit),
                  );
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  cubit.toggleTheme();
                },
                icon: Icon(
                  cubit.themeMode == ThemeMode.light
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
              ),
            ],
          ),
          body: cubit.currentIndex == 0
              ? articleBuilder(cubit.businessSearchResults, context)
              : cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}

class ArticleSearchDelegate extends SearchDelegate {
  final AppCubit cubit;

  ArticleSearchDelegate(this.cubit);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    cubit.searchBusiness(query);
    return articleBuilder(cubit.businessSearchResults, context, isSearch: true);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    cubit.searchBusiness(query);
    return articleBuilder(cubit.businessSearchResults, context, isSearch: true);
  }
}
