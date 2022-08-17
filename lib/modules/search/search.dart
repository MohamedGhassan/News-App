import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/news_app/cubit/cubit.dart';
import '../../layout/news_app/cubit/state.dart';
import '../../layout/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField2(
                    textKeyboard: TextInputType.text,
                    textLabel: 'Search',
                    label: 'Search',
                    controller: searchController,
                    prefix: Icons.search,
                    onchange: (value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'search must not be empty';
                        }
                        return null;
                      }
                  ),
                ),
              ),
              Expanded(child: articleBuilder(list, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
