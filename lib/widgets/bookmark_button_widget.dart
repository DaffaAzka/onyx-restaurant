import 'package:flutter/material.dart';
import 'package:onyx_restaurant/data/models/restaurant.dart';
import 'package:onyx_restaurant/data/models/restaurant_list_item.dart';
import 'package:onyx_restaurant/provider/is_bookmark_provider.dart';
import 'package:provider/provider.dart';
import 'package:onyx_restaurant/provider/local_database_provider.dart';

class BookmarkButtonWidget extends StatefulWidget {
  const BookmarkButtonWidget({super.key, required this.restaurant});

  @override
  State<BookmarkButtonWidget> createState() => _BookmarkButtonWidgetState();
  final Restaurant restaurant;
}

class _BookmarkButtonWidgetState extends State<BookmarkButtonWidget> {
  @override
  void initState() {
    final isBookmarkProvider = context.read<IsBookmarkProvider>();
    final localDatabaseProvider = context.read<LocalDatabaseProvider>();
    Future.microtask(() async {
      await localDatabaseProvider.loadRestaurantById(widget.restaurant.id);
      isBookmarkProvider.isBookmarked = localDatabaseProvider.checkIfFavorite(widget.restaurant.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: context.watch<IsBookmarkProvider>().isBookmarked ? Icon(Icons.bookmark) : Icon(Icons.bookmark_border),
      onPressed: () {
        final localDatabaseProvider = context.read<LocalDatabaseProvider>();
        final isBookmarkProvider = context.read<IsBookmarkProvider>();
        final isBookmarked = isBookmarkProvider.isBookmarked;

        final RestaurantListItem restaurantListItem = RestaurantListItem(
          id: widget.restaurant.id,
          name: widget.restaurant.name,
          description: widget.restaurant.description,
          pictureId: widget.restaurant.pictureId,
          city: widget.restaurant.city,
          rating: widget.restaurant.rating,
        );

        if (!isBookmarked) {
          localDatabaseProvider.addRestaurant(restaurantListItem);
        } else {
          localDatabaseProvider.deleteRestaurant(widget.restaurant.id);
        }

        isBookmarkProvider.isBookmarked = !isBookmarked;
      },
    );
  }
}
