import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/news_app/cubit/state.dart';
import '../../../modules/network/local/cache_helper.dart';
import '../../../modules/network/remote/dio_helper.dart';
import '../../../modules/news_tasks/business/business_screen.dart';
import '../../../modules/news_tasks/science/science_screen.dart';
import '../../../modules/news_tasks/sports/sporst_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value)
      {
        emit(AppChangeModeState());
      });
    }
  }

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];
  List<Widget> screen = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void ChangeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
    if (index == 1) getSports();
    if (index == 2) getScience();

  }

  List<dynamic> business = [];

  void getBusiness() {
    if(business.length == 0)
      {
        emit(NewsGetBusinessLoadingState());
        DioHelper.getData(url: 'v2/top-headlines', query: {
          'country': 'eg',
          ' category': 'business',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        }).then((value) {
          business = value!.data['articles'];
          print(business[0]['title']);
          emit(NewsGetBusinessSuccessState());
        }).catchError((error) {
          print(error.toString());
          emit(NewsGetBusinessErrorState(error.toString()));
        });
      }else
    {
      emit(NewsGetBusinessSuccessState());
    }

  }

  List<dynamic> sports = [];

  void getSports() {
    if (sports.length == 0) {
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        sports = value!.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    if (science.length == 0) {
      emit(NewsGetScienceLoadingState());

      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        science = value!.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];  
  void getSearch(String? value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      search = value!.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
