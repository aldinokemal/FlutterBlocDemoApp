import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/repos/repository/login_repository.dart';
import 'package:my_app/screens/forgetpassword/bloc/forgetpassword_bloc.dart';
import 'package:my_app/screens/login/login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_app/screens/register/bloc/register_bloc.dart';

import 'config/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('id')],
        path: 'assets/locales',
        fallbackLocale: Locale('id'),
        child: DemoApp()),
  );
}

class DemoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   statusBarIconBrightness: Brightness.dark,
    //   statusBarBrightness: !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
    //   systemNavigationBarColor: Colors.white,
    //   systemNavigationBarDividerColor: Colors.grey,
    //   systemNavigationBarIconBrightness: Brightness.dark,
    // ));
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc()),
          BlocProvider<RegisterBloc>(create: (BuildContext context) => RegisterBloc()),
          BlocProvider<ForgetpasswordBloc>(create: (BuildContext context) => ForgetpasswordBloc()),
        ],
        child: MaterialApp(
          initialRoute: '/splash',
          routes: appRoutes,
          builder: EasyLoading.init(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'BI App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.latoTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
        ));
  }
}
