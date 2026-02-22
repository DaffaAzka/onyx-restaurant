import 'package:flutter/material.dart';
import 'package:onyx_restaurant/core/api_state.dart';
import 'package:onyx_restaurant/provider/restaurants_provider.dart';
import 'package:onyx_restaurant/widgets/error_widget.dart';
import 'package:onyx_restaurant/widgets/restaurant_card.dart';
import 'package:onyx_restaurant/style/typography/onyx_text_styles.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Provider.of<RestaurantsProvider>(context, listen: false).fetchRestaurants(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RestaurantsProvider>().getState;
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsGeometry.all(12),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search restaurants...",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _searchController.clear();
                        Provider.of<RestaurantsProvider>(context, listen: false).searchRestaurants('');
                      },
                    )
                  : null,
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onEditingComplete: () {
              Provider.of<RestaurantsProvider>(context, listen: false).searchRestaurants(_searchController.text);
            },
            onChanged: (_) => setState(() {}),
          ),
        ),

        Expanded(
          child: switch (state) {
            ApiInitial() || ApiLoading() => const Center(child: CircularProgressIndicator()),

            ApiSuccess(data: final data) => ListView.builder(
              itemCount: data.count,
              itemBuilder: (context, index) {
                return RestaurantCard(item: data.restaurants[index]);
              },
            ),

            ApiError(message: final message) => CustomErrorWidget(error: message),
          },
        ),
      ],
    );
  }
}
