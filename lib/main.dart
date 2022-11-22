import 'package:alltalk_translate/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// PROVIDERDA OKURKEN WATCH ILE OKU, YAZARKEN
// ref.read(langCodeProvider.notifier).state = element.toString();
// TARZINDA YAZDIR

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
        // colorSchemeSeed: Colors.red,
        primarySwatch: Colors.teal,
        primaryColor: const Color(0xFF3B4257),
        secondaryHeaderColor: Colors.yellow,
        fontFamily: "FredokaOne",
      ),
    );
  }
}
