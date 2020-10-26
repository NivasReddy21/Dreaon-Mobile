import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/router.dart' as router;
import 'config/theme.dart' as theme;
import 'constants/constants.dart';
import 'constants/routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final initTheme = theme.darkTheme;
    return ThemeProvider(
      initTheme: initTheme,
      child: Builder(builder: (context) {
        return MultiProvider(
          providers: [
            StreamProvider<User>.value(
              value: FirebaseAuth.instance.authStateChanges(),
            )
          ],
          child: MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.of(context),
            onGenerateRoute: router.generateRoute,
            initialRoute: AppRoutes.splash,
          ),
        );
      }),
    );
  }
}
