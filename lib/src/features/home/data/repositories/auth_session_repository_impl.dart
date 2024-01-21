import 'package:dartz/dartz.dart';
import 'package:test_pragma_app/src/features/home/data/models/cat_breed_image_model.dart';

import '../../../../core/erros/erros.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/cat_breed_model.dart';
import '../services/auth_session_service.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeService _homeService;

  HomeRepositoryImpl(
    this._homeService,
  );

  @override
  Future<Either<ErrorModel, List<CatBreedsModel>>> getCatsBreeds() async {
    try {
      return Right(
        await _homeService.getCatsBreeds(),
      );
    } catch (e) {
      return Left(
        ErrorModel(
          code: 'Error obteniendo la lista de gatos',
        ),
      );
    }
  }

  @override
  Future<Either<ErrorModel, CatImageModel>> getCatImage({
    required String catId,
  }) async {
    try {
      return Right(
        await _homeService.getCatImage(
          catId: catId,
        ),
      );
    } catch (e) {
      return Left(
        ErrorModel(
          code: 'Error obteniendo la imagen del gato',
        ),
      );
    }
  }
}
