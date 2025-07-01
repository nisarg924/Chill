import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/const.dart';
import '../storage/shared_pref_utils.dart';
import '../utils/app_themes.dart';
import '../utils/enum.dart';

// Events
abstract class ThemeEvent {}

class ChangeThemes extends ThemeEvent {
  final ThemeData? appTheme;
  final int? fontStyle;
  final int? fontHeight;

  ChangeThemes(this.appTheme, this.fontStyle, this.fontHeight);
}

class ChangeFontStyle extends ThemeEvent {
  final String? fontStyle;

  ChangeFontStyle(this.fontStyle);
}

class ChangeFontHeight extends ThemeEvent {
  final int? fontHeight;

  ChangeFontHeight(this.fontHeight);
}

// States
class ThemesState {
  final ThemeData? themeData;
  final String? fontStyle;
  final num? fontHeight;

  ThemesState({this.themeData, this.fontStyle, this.fontHeight});
}

// BLoC
class ThemesBloc extends Bloc<ThemeEvent, ThemesState> {
  ThemesBloc()
      : super(
          ThemesState(
            themeData: AppThemes.appThemeData(FontStyleType
                    .values[SharedPrefUtils.getThemesData().fontStyleType ??
                        FontStyleType.Poppins.index]
                    .name)[
                AppTheme.values[SharedPrefUtils.getThemesData().themeType ??
                    AppTheme.lightTheme.index]],
            fontStyle: FontStyleType
                .values[SharedPrefUtils.getThemesData().fontStyleType ??
                    FontStyleType.Poppins.index]
                .name,
            fontHeight: FontSizeType
                .values[SharedPrefUtils.getThemesData().fontSizeType ??
                    FontSizeType.normal.index]
                .value,
          ),
        ) {
    on<ChangeThemes>(
      (event, emit) {
        emit(
          ThemesState(
            themeData: event.appTheme,
            fontStyle: FontStyleType
                .values[event.fontStyle ?? FontStyleType.Poppins.index].name,
            fontHeight: FontSizeType
                .values[event.fontHeight ?? FontSizeType.normal.index].value,
          ),
        );
      },
    );

    on<ChangeFontStyle>(
      (event, emit) {
        emit(
          ThemesState(
            fontStyle: event.fontStyle,
          ),
        );
      },
    );

    on<ChangeFontHeight>(
      (event, emit) {
        emit(
          ThemesState(
            fontHeight: FontSizeType
                .values[event.fontHeight ?? FontSizeType.normal.index].value,
          ),
        );
      },
    );
  }
}
