import 'package:dio/dio.dart';
import 'package:unsplash_gallery/model/photo_model.dart';

class ApiService {
  final Dio _dio = Dio();
  static const String _baseUrl = 'https://api.unsplash.com';
  static const String _apiKey = 'APIKEY';

  Future<List<Photo>> fetchPhotos() async {
    try {
      final response = await _dio.get('$_baseUrl/photos/?client_id=$_apiKey');
      print("Response: $response");
      List jsonResponse = response.data;
      print("Response data: ${response.data}");
      return jsonResponse.map((photo) => Photo.fromJson(photo)).toList();
    } catch (error) {
      throw Exception('Failed to load photos: $error');
    }
  }
}
