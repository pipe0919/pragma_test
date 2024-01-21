import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/data/repositories/auth_session_repository_impl.dart';
import '../../features/home/data/services/auth_session_service.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/use_cases/get_cat_image_use_case.dart';
import '../../features/home/domain/use_cases/get_cats_breeds_use_case.dart';
import '../../features/home/ui/cubit/home_cubit.dart';

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
      () => HomeCubit(sl(), sl()),
    );
  }

  // RegisterRepository
  Future<void> _registerRepositories() async {
    sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(sl()),
    );
  }

  Future<void> _registerUseCases() async {
    sl.registerLazySingleton(
      () => GetCatsBreedsUseCase(sl()),
    );
    sl.registerLazySingleton(
      () => GetCatsImageUseCase(sl()),
    );
  }

  Future<void> _registerDataSources() async {
    sl.registerLazySingleton<HomeService>(
      () => HomeServiceImpl(
        sl(
          instanceName: 'dio',
        ),
      ),
    );
  }

  void _registerDio() {
    sl.registerSingleton<Dio>(
      Dio(
        BaseOptions(
          baseUrl: 'https://api.thecatapi.com/v1',
          headers: {"x-api-key": "bda53789-d59e-46cd-9bc4-2936630fde39"},
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
          receiveDataWhenStatusError: true,
        ),
      ),
      instanceName: 'dio',
    );
  }
}
