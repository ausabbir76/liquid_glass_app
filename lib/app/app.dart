import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import 'router/app_router.dart';
import 'theme/theme_controller.dart';

/// Root widget of the application.
///
/// Wires together the router and the theme controller. The old private
/// `_BrightnessScope` InheritedWidget is replaced by [themeControllerProvider].
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = ref.watch(themeControllerProvider);
    final router = ref.watch(routerProvider);
    final isDark = brightness == Brightness.dark;

    return CupertinoApp.router(
      title: 'Liquid Glass Widgets',
      theme: CupertinoThemeData(brightness: brightness),
      routerConfig: router,
      // Localizations: generated AppLocalizations (lib/l10n/*.arb) plus the
      // Material/Cupertino delegates demo pages rely on.
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // Provide a matching Material Theme for any Scaffold widgets in demo pages.
      builder: (context, child) => Theme(
        data: isDark
            ? ThemeData.dark(useMaterial3: true)
            : ThemeData.light(useMaterial3: true),
        child: child!,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
