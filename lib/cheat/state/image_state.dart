import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

import 'package:acorn_flutter_workshop/cheat/model/image_info.dart';
import 'package:flutter/material.dart';

class ImageState extends ChangeNotifier {
  NasaImageInfo? currentImage;
  var favorites = <NasaImageInfo>[];
  var searchResult = <NasaImageInfo>[];

  ImageState() {
    _initWithLocalData();
  }

  void loadNextImage() {
    currentImage = _getRandomFromSearch();
    notifyListeners();
  }

  void toggleFavorite(String id) {
    var image = searchResult.firstWhere((element) => element.id == id);
    if (favorites.contains(image)) {
      favorites.remove(image);
    } else {
      favorites.add(image);
    }
    notifyListeners();
  }

  void toggleCurrentFavorite() {
    if (favorites.contains(currentImage)) {
      favorites.remove(currentImage);
    } else if (currentImage != null) {
      favorites.add(currentImage!);
    }
    notifyListeners();
  }

  NasaImageInfo? _getRandomFromSearch() {
    if (searchResult.isEmpty) return null;
    int randomIndex = Random().nextInt(searchResult.length);
    return searchResult[randomIndex];
  }

  void _initWithLocalData() async {
    var nasaJson = await rootBundle.loadString("assets/nasa_image_data.json");
    _initFromString(nasaJson);
  }

  void _initFromNasaApi() {
    var apiKey = "DEMO_KEY";
    http
        .get(Uri.parse(
            'https://api.nasa.gov/planetary/apod?api_key=$apiKey&thumbs=true&count=50'))
        .then((response) {
      if (response.statusCode == 200) {
        _initFromString(response.body);
      }
    });
  }

  void _initFromString(String json) {
    var items = jsonDecode(json) as List;
    searchResult = items
        .where((element) => element['media_type'] == 'image')
        .map((item) => NasaImageInfo(
            url: item['thumbnail_url'] ?? item['url'],
            title: item['title'],
            id: item['url']))
        .toList();
    currentImage = _getRandomFromSearch();
    notifyListeners();
  }
}
