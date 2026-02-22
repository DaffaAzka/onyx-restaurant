import 'package:flutter/material.dart';
import 'package:onyx_restaurant/data/models/restaurant_list_item.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key, required this.item});

  final RestaurantListItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: Row(
          spacing: 10,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 80, minHeight: 80, maxWidth: 120, minWidth: 120),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(4)),
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/medium/${item.pictureId}",
                  width: 120,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                children: [
                  Text(item.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 2,
                    children: [
                      Icon(Icons.location_city, size: 18),
                      Text(item.city, style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 2,
                    children: [
                      Icon(Icons.star, color: Colors.amberAccent, size: 18),
                      Text(item.rating.toString(), style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
