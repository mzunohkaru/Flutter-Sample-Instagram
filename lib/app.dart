import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Core/Root/View/splash_view.dart';
import 'Provider/theme_provider.dart';

class App extends ConsumerWidget {
  FlexScheme usedScheme = FlexScheme.blueWhale;

  App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram',
      themeMode: ref.watch(themeProvider),
      theme: FlexThemeData.light(
        scheme: usedScheme,
        appBarElevation: 0.5,
        useMaterial3: true,
        typography: Typography.material2021(platform: defaultTargetPlatform),
      ),
      darkTheme: FlexThemeData.dark(
        scheme: usedScheme,
        appBarElevation: 2,
        useMaterial3: true,
        typography: Typography.material2021(platform: defaultTargetPlatform),
      ),
      home: const SplashView(),
    );
  }
}
