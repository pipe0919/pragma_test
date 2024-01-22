import 'package:dartz/dartz.dart';

import '../../../../core/erros/erros.dart';
import '../../data/models/cat_breed_model.dart';
import '../repositories/home_repository.dart';

class GetCatsBreedsUseCase {
  final HomeRepository _homeRepository;

  GetCatsBreedsUseCase(
    this._homeRepository,
  );

  Future<Either<ErrorModel, List<CatBreedsModel>>> call() async {
    return await _homeRepository.getCatsBreeds();
  }
}
