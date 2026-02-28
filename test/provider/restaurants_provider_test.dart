import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onyx_restaurant/core/api_state.dart';
import 'package:onyx_restaurant/data/api/api_service.dart';
import 'package:onyx_restaurant/data/models/responses/list_restaurant_response.dart';
import 'package:onyx_restaurant/provider/restaurants_provider.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApiService;
  late RestaurantsProvider restaurantsProvider;

  setUp(() {
    mockApiService = MockApiService();
    restaurantsProvider = RestaurantsProvider(mockApiService);
  });

  group("Restaurants Provider Testing", () {
    test('State provider dibuat (ApiInitial)', () {
      final initialState = restaurantsProvider.getState;

      expect(initialState, isA<ApiInitial>());
    });

    test('Mengembalikan daftar restoran', () async {
      final successResponse = ListRestaurantResponse(
        error: false,
        message: 'success',
        count: 0,
        restaurants: [],
      );

      when(() => mockApiService.getRestaurantListing())
          .thenAnswer((_) async => successResponse);

      await restaurantsProvider.fetchRestaurants();
      final state = restaurantsProvider.getState;

      expect(state, isA<ApiSuccess<ListRestaurantResponse>>());
      final successState = state as ApiSuccess<ListRestaurantResponse>;
      expect(successState.data, equals(successResponse));
    });

    test('Mengembalikan error ketika API gagal', () async {
      final errorMessage = 'Exception: failed to load';

      when(() => mockApiService.getRestaurantListing())
          .thenThrow(Exception('failed to load'));

      await restaurantsProvider.fetchRestaurants();
      final state = restaurantsProvider.getState;

      expect(state, isA<ApiError<ListRestaurantResponse>>());
      final errorState = state as ApiError<ListRestaurantResponse>;
      expect(errorState.message, equals(errorMessage));
    });
  });
}
