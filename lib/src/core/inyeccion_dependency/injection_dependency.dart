import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/data/services/local/home_local_service.dart';
import '../../features/home/data/services/network/home_network_service.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/use_cases/get_cats_breeds_use_case.dart';
import '../../features/home/ui/cubit/home_cubit.dart';
import '../shared_prefences/shared_preferences.dart';

final sl = GetIt.instance;

class Dependencies {
  Future<void> setup() async {
    _registerBlocs();
    _registerRepositories();
    _registerUseCases();
    _registerDio();
    _registerDataSources();
  }

  Future<void> _registerBlocs() async {
    sl.registerFactory(
      () => HomeCubit(sl())..getCatsBreeds(),
    );
  }

  // RegisterRepository
  Future<void> _registerRepositories() async {
    sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(sl(), sl()),
    );
  }

  Future<void> _registerUseCases() async {
    sl.registerLazySingleton(
      () => GetCatsBreedsUseCase(sl()),
    );
  }

  Future<void> _registerDataSources() async {
    sl.registerLazySingleton<HomeNetworkService>(
      () => HomeNetworkServiceImpl(
        sl(
          instanceName: 'dio',
        ),
      ),
    );

    sl.registerLazySingleton<HomeLocalService>(
      () => HomeLocalServiceImpl(
        sl(instanceName: 'preferences'),
      ),
    );
  }

  void _registerDio() {
    sl.registerSingleton<Dio>(
      Dio(
        BaseOptions(
          baseUrl: dotenv.env['SERVER_API']!,
          headers: {"x-api-key": dotenv.env['SERVER_API_KEY']!},
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
          receiveDataWhenStatusError: true,
        ),
      ),
      instanceName: 'dio',
    );
    sl.registerFactory<PreferenciasUsuario>(
      () => PreferenciasUsuario(),
      instanceName: 'preferences',
    );
  }
}
