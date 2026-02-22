import 'dart:convert';

import 'package:onyx_restaurant/data/models/responses/detail_restaurant_response.dart';
import 'package:onyx_restaurant/data/models/responses/list_restaurant_response.dart';
import 'package:http/http.dart' as http;
import 'package:onyx_restaurant/data/models/responses/search_restaurant_response.dart';

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

  Future<SearchRestaurantResponse> searchRestaurantListing(
    String search,
  ) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$search"));
    if (response.statusCode == 200) {
      return SearchRestaurantResponse.fromMap(jsonDecode(response.body));
    } else {
      throw Exception("Something wrong while call the API");
    }
  }

  Future<DetailRestaurantResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return DetailRestaurantResponse.fromMap(jsonDecode(response.body));
    } else {
      throw Exception("Something wrong while call the API");
    }
  }
}
