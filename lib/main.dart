import 'package:alltalk_translate/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.routeGenrator,
      title: 'AllTalk Translate',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Color.fromARGB(255, 225, 92, 99),
        // Color.fromARGB(255, 30, 166, 188)
        // Color.fromARGB(255, 255, 192, 90)
        secondaryHeaderColor: Colors.yellow,
        fontFamily: "FredokaOne",
      ),
    );
  }
}
