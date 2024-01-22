import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/erros/erros.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/cat_breed_model.dart';
import '../services/local/home_local_service.dart';
import '../services/network/home_network_service.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeNetworkService _homeService;
  final HomeLocalService _homeLocalServiceImpl;

  HomeRepositoryImpl(
    this._homeService,
    this._homeLocalServiceImpl,
  );

  @override
  Future<Either<ErrorModel, List<CatBreedsModel>>> getCatsBreeds() async {
    try {
      final catsFromLocalStorage = _homeLocalServiceImpl.getCatsBreeds();
      if (catsFromLocalStorage.isNotEmpty) {
        return Right(
          await Future<List<CatBreedsModel>>.value(catsFromLocalStorage),
        );
      }
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
}
