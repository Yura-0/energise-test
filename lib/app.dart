import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'features/home/home_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: HomePage(),
    );
  }
}
