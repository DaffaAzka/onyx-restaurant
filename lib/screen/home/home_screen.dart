import 'package:flutter/material.dart';
import 'package:onyx_restaurant/core/api_state.dart';
import 'package:onyx_restaurant/data/models/responses/list_restaurant_response.dart';
import 'package:onyx_restaurant/provider/restaurants_provider.dart';
import 'package:onyx_restaurant/widgets/restaurant_card.dart';
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
        TextField(
          controller: _searchController,
          decoration: const InputDecoration(labelText: "Search"),
          onEditingComplete: () {
            Provider.of<RestaurantsProvider>(context, listen: false).searchRestaurants(_searchController.text);
          },
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

            ApiError<ListRestaurantResponse>() => ErrorWidget(state.message),
          },
        ),
      ],
    );
  }
}
