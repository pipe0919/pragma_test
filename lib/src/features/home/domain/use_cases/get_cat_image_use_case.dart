import 'package:dartz/dartz.dart';

import '../../../../core/erros/erros.dart';
import '../../data/models/cat_breed_image_model.dart';
import '../repositories/home_repository.dart';

class GetCatsImageUseCase {
  final HomeRepository _homeRepository;

  GetCatsImageUseCase(
    this._homeRepository,
  );

  Future<Either<ErrorModel, CatImageModel>> call({
    required String catId,
  }) async {
    return await _homeRepository.getCatImage(
      catId: catId,
    );
  }
}
