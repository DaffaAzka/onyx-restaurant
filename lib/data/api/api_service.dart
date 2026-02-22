import 'dart:convert';

import 'package:onyx_restaurant/data/models/responses/list_restaurant_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<ListRestaurantResponse> getRestaurantListing() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      return ListRestaurantResponse.fromMap(jsonDecode(response.body));
    } else {
      throw Exception("Something wrong while call the API");
    }
  }
}
