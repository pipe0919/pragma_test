import 'package:dartz/dartz.dart';

import '../../../../core/erros/erros.dart';
import '../../data/models/cat_breed_image_model.dart';
import '../../data/models/cat_breed_model.dart';

abstract class HomeRepository {
  Future<Either<ErrorModel, List<CatBreedsModel>>> getCatsBreeds();
  Future<Either<ErrorModel, CatImageModel>> getCatImage({
    required String catId,
  });
}
