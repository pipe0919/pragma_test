import 'dart:convert';

import '../../../../../core/shared_prefences/shared_preferences.dart';
import '../../models/cat_breed_model.dart';

abstract class HomeLocalService {
  List<CatBreedsModel> getCatsBreeds();
}

class HomeLocalServiceImpl implements HomeLocalService {
  final PreferenciasUsuario _preferences;

  HomeLocalServiceImpl(
    this._preferences,
  );

  @override
  List<CatBreedsModel> getCatsBreeds() {
    try {
      List<String>? catBreedsJsonList = _preferences.catList;
      if (catBreedsJsonList.isNotEmpty) {
        final response = catBreedsJsonList
            .map(
                (jsonString) => CatBreedsModel.fromJson(jsonDecode(jsonString)))
            .toList();

        return response;
      }
      return [];
    } catch (e) {
      throw Exception('Error getting the cats');
    }
  }
}
