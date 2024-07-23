import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/states.dart';
import 'BuildArticleItem.dart';
import 'cubit.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).sports;

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: list.length,
        );
      },
    );
  }
}
