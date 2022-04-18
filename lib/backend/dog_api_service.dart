/*import 'dart:convert';

import 'package:doglover/models/breed.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class DogApiService {
  String _baseUrl = 'https://api.thedogapi.com/v1/';
  String _jsonResponse = '';

  Future<String> _loadAsset() async {
    return await rootBundle.loadString('secrets/secrets.json');
  }

  Future<List<Breed>> getBreeds() async {
    http.Response response = await makeApiCall('breeds');
    if (response.statusCode == 200) {
      _jsonResponse = response.body;
      List<dynamic> dogInfo = jsonDecode(_jsonResponse);
      return dogInfo.map((data) => Breed.fromJson(data)).toList();
    }
    throw Exception();
  }

  Future<String> getBreedImageUrl(String id) async {
    http.Response response = await makeApiCall('images/search?breed_id=$id');
    if (response.statusCode == 200) {
      _jsonResponse = response.body;
      List<dynamic> dogInfo = jsonDecode(_jsonResponse);
      if (dogInfo.isEmpty) {
        throw ('no image for breed');
      }
      return dogInfo[0]['url'];
    }
    throw Exception();
  }

  Future<http.Response> makeApiCall(String endpoint) async {
    final apiData = await _loadAsset();
    final String key = jsonDecode(apiData)["api_key"];
    Map<String, String> headers = {'X-Api-Key': key};
    var response = await http.get('$_baseUrl$endpoint', headers: headers);
    return response;
  }
}*/