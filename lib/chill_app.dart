import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/constants/app_string.dart';
import 'package:social_app/feature/user/connect_to_friends_screen.dart';
import 'package:social_app/feature/user/wrapper.dart';
import 'core/navigation_key/global_key.dart';
import 'core/themes/dynamic.dart';
import 'core/themes/dynamic_themes.dart';
import 'feature/user/login_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<FontBloc>(create: (BuildContext context) => FontBloc()),
            BlocProvider<ThemesBloc>(create: (BuildContext context) => ThemesBloc()),],
          child: BlocBuilder<ThemesBloc, ThemesState>(
            builder: (context,state) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: MaterialApp(
                  builder: EasyLoading.init(
                    builder: (context, child) {
                      return MediaQuery(
                        data: MediaQuery.of(
                          context,
                        ).copyWith(textScaler: TextScaler.linear(state.fontHeight?.toDouble() ?? 1.0)),
                        child: child!,
                      );
                    },
                  ),
                  theme: state.themeData,
                  navigatorKey: GlobalVariable.navigatorKey,
                  debugShowCheckedModeBanner: false,
                  locale: Locale("en"),
                  title: AppString.appName,
                  routes: const <String, WidgetBuilder>{},
                  home: Wrapper(),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}