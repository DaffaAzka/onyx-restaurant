import 'package:flutter/material.dart';
import 'package:onyx_restaurant/provider/navigation_provider.dart';
import 'package:onyx_restaurant/provider/theme_provider.dart';
import 'package:onyx_restaurant/screen/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => ThemeProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeMode mode = context.watch<ThemeProvider>().getThemeMode;
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NavigationProvider())],
      child: MaterialApp(
        title: 'Onyx Restaurant',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.light),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
        ),
        themeMode: mode ,
        initialRoute: '/',
        routes: {'/': (context) => MainScreen()},
      ),
    );
  }
}
