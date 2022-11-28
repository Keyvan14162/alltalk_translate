import 'package:alltalk_translate/generated/codegen_loader.g.dart';
import 'package:alltalk_translate/route_generator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('tr')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: const ProviderScope(child: MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  /// ↓↓ ADDED FOR THEME CHANGE

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light; // or system

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // easy localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.routeGenrator,
      title: 'AllTalk Translate',

      // light theme
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,

        // main background etc. color
        primaryColor: Colors.white,

        // dark text, icon etc. color
        backgroundColor: Color.fromARGB(255, 0, 23, 39),

        fontFamily: "FredokaOne",
      ),
      // // standard dark theme : ThemData.Dark
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        // iconTheme: IconThemeData(color: Colors.white),

        primarySwatch: Colors.teal,
        // main background etc. color
        primaryColor: Color.fromARGB(255, 0, 23, 39),

        // dark text, icon etc. color
        backgroundColor: Colors.white,
        fontFamily: "FredokaOne",
      ),
      themeMode: _themeMode, // device controls theme
    );
  }

  // change theme
  changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
