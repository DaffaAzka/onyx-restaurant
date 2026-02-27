import 'package:flutter/material.dart';
import 'package:onyx_restaurant/data/local_database_service.dart';
import 'package:onyx_restaurant/provider/is_bookmark_provider.dart';
import 'package:onyx_restaurant/provider/local_database_provider.dart';
import 'package:onyx_restaurant/provider/navigation_provider.dart';
import 'package:onyx_restaurant/provider/restaurant_provider.dart';
import 'package:onyx_restaurant/provider/theme_provider.dart';
import 'package:onyx_restaurant/main_screen.dart';
import 'package:onyx_restaurant/screen/detail/detail_screen.dart';
import 'package:onyx_restaurant/style/theme/onyx_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      Provider(create: (_) => LocalDatabaseService()),
      ChangeNotifierProvider(create: (context) => LocalDatabaseProvider(context.read<LocalDatabaseService>())),
      ChangeNotifierProvider(create: (_) => IsBookmarkProvider()),
    ], child: const MyApp()),
  );
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
        theme: OnyxTheme.lightTheme,
        darkTheme: OnyxTheme.darkTheme,
        themeMode: mode,
        initialRoute: '/',
        routes: {
          '/': (context) => MainScreen(),
          '/detail': (context) => ChangeNotifierProvider(
            create: (_) => RestaurantProvider(),
            child: DetailScreen(
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
          ),
        },
      ),
    );
  }
}
