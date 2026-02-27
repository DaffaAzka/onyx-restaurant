import 'package:flutter/material.dart';
import 'package:onyx_restaurant/core/api_state.dart';
import 'package:onyx_restaurant/provider/restaurant_provider.dart';
import 'package:onyx_restaurant/widgets/bookmark_button_widget.dart';
import 'package:onyx_restaurant/widgets/error_widget.dart';
import 'package:onyx_restaurant/style/typography/onyx_text_styles.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id});
  final String id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Provider.of<RestaurantProvider>(
        context,
        listen: false,
      ).fetchRestaurant(widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RestaurantProvider>().getState;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Restaurant"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: switch (state) {
        ApiInitial() ||
        ApiLoading() => const Center(child: CircularProgressIndicator()),

        ApiSuccess(data: final data) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/large/${data.restaurant.pictureId}",
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.restaurant.name,
                            style: OnyxTextStyles.headlineLarge,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  "${data.restaurant.address}, ${data.restaurant.city}",
                                  style: OnyxTextStyles.labelLarge,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          data.restaurant.rating.toString(),
                          style: OnyxTextStyles.labelLarge,
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    BookmarkButtonWidget(restaurant: data.restaurant),
                  ],
                ),
                const SizedBox(height: 12),

                Wrap(
                  spacing: 6,
                  children: data.restaurant.categories.map((category) {
                    return Chip(
                      label: Text(
                        category.name,
                        style: OnyxTextStyles.labelMedium,
                      ),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),

                Text(
                  data.restaurant.description,
                  style: OnyxTextStyles.labelLarge,
                ),
                const SizedBox(height: 20),

                Text("Foods", style: OnyxTextStyles.titleMedium),
                const SizedBox(height: 8),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 4,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  children: data.restaurant.menus.foods.map((food) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.restaurant,
                            size: 14,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              food.name,
                              style: OnyxTextStyles.titleSmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                Text("Drinks", style: OnyxTextStyles.titleMedium),
                const SizedBox(height: 8),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 4,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  children: data.restaurant.menus.drinks.map((drink) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.local_drink,
                            size: 14,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              drink.name,
                              style: OnyxTextStyles.titleSmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                Text("Reviews", style: OnyxTextStyles.titleMedium),
                const SizedBox(height: 8),
                ...data.restaurant.customerReviews.map((review) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(review.name, style: OnyxTextStyles.titleSmall),
                            const Spacer(),
                            Text(review.date, style: OnyxTextStyles.labelSmall),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(review.review, style: OnyxTextStyles.labelLarge),
                        const Divider(),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

        ApiError(message: final message) => CustomErrorWidget(error: message),
      },
    );
  }
}
