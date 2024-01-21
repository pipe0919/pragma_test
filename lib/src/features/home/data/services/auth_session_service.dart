import 'package:dio/dio.dart';

import '../models/cat_breed_image_model.dart';
import '../models/cat_breed_model.dart';

abstract class HomeService {
  Future<List<CatBreedsModel>> getCatsBreeds();
  Future<CatImageModel> getCatImage({
    required String catId,
  });
}

class HomeServiceImpl implements HomeService {
  final Dio _dioCat;

  HomeServiceImpl(
    this._dioCat,
  );

  @override
  Future<List<CatBreedsModel>> getCatsBreeds() async {
    try {
      final response = await _dioCat.get(
        '/breeds',
      );
      if (response.statusCode != 200) {
        throw Exception('Error getting the cats');
      }
      List<CatBreedsModel> cats = [];
      for (var cat in response.data) {
        cats.add(CatBreedsModel.fromJson(cat));
      }

      return cats;
    } catch (e) {
      throw Exception('Error getting the cats');
    }
  }

  @override
  Future<CatImageModel> getCatImage({
    required String catId,
  }) async {
    try {
      final response = await _dioCat.get(
        '/images/search?breed_ids=$catId',
      );
      if (response.statusCode != 200) {
        throw Exception('Error getting the cats');
      }

      return CatImageModel.fromJson(response.data[0]);
    } catch (e) {
      throw Exception('Error getting the cats');
    }
  }
}
