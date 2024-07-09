import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../theme/themes.dart';

abstract class ThemeEvent {}

class SwitchThemeEvent extends ThemeEvent {}

abstract class ThemeState {
  ThemeData themeData;
  int index;

  ThemeState({required this.themeData, required this.index});
}

class ThemeSuccessState extends ThemeState {
  ThemeSuccessState({required super.themeData, required super.index});
}

class InitialThemeState extends ThemeState {
  InitialThemeState()
      : super(
          themeData: MyTheme.themes[0],
          index: 0
        );
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  int currentIndex = 0;
  final List<ThemeData> themes = MyTheme.themes;

  ThemeBloc() : super(InitialThemeState()) {
    on((SwitchThemeEvent event, emit) {
      ++currentIndex;
      if (currentIndex >= themes.length) {
        currentIndex = 0;
      }
      emit(ThemeSuccessState(themeData: themes[currentIndex], index: currentIndex));
    });
  }
}
