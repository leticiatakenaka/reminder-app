import "package:flutter/material.dart";
import "package:lembretes_app/view/home.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:intl/date_symbol_data_local.dart";
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  initializeDateFormatting("pt_BR", null).then((_) {
    runApp(const Main());
  });
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [
          Locale("pt", "BR"),
        ],
        locale: const Locale("pt", "BR"),
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        home: const Home());
  }
}
