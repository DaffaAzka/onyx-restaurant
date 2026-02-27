import 'package:flutter/material.dart';
import 'package:onyx_restaurant/provider/local_database_provider.dart';
import 'package:onyx_restaurant/widgets/restaurant_card.dart';
import 'package:provider/provider.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  void initState() {
    Future.microtask(() {
      if (!mounted) return;
      context.read<LocalDatabaseProvider>().loadRestaurants();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LocalDatabaseProvider>().restaurants;
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsGeometry.all(12),
          child: ListView.builder(
            itemCount: state?.length ?? 0,
            itemBuilder: (context, index) {
              return RestaurantCard(item: state![index]);
            },
          ),
        ),
      ],
    );
  }
}
