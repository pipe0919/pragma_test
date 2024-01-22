import 'package:dio/dio.dart';

import '../../models/cat_breed_model.dart';

abstract class HomeNetworkService {
  Future<List<CatBreedsModel>> getCatsBreeds();
}

class HomeNetworkServiceImpl implements HomeNetworkService {
  final Dio _dioCat;

  HomeNetworkServiceImpl(
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
}
