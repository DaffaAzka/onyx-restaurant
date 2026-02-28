import 'package:flutter/material.dart';
import 'package:onyx_restaurant/data/api/api_service.dart';
import 'package:onyx_restaurant/provider/navigation_provider.dart';
import 'package:onyx_restaurant/provider/restaurants_provider.dart';
import 'package:onyx_restaurant/screen/home/home_screen.dart';
import 'package:onyx_restaurant/screen/settings/settings_screen.dart';
import 'package:onyx_restaurant/screen/bookmarks/bookmarks_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();
    return Scaffold(
      body: switch (nav.getIndexNavigationBar) {
        0 => ChangeNotifierProvider(create: (_) => RestaurantsProvider(ApiService()), child: HomeScreen()),
        1 => SettingsScreen(),
        _ => BookmarksScreen(),
      },
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: nav.getIndexNavigationBar,
        onTap: (value) {
          Provider.of<NavigationProvider>(context, listen: false).setIndexNavigationBar(value);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Bookmarks"),
        ],
      ),
    );
  }
}
