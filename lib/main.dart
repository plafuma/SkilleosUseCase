import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/presentation/screens/bottom_navigation.dart';

void main() {
  runApp(
    const ProviderScope(
      child: SkilleosApp(),
    ),
  );
}

class SkilleosApp extends StatelessWidget {
  const SkilleosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skilleos Use case',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('fr', ''),
      ],
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const BottomNavigation(),
    );
  }
}
