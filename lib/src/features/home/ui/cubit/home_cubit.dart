import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/cat_breed_image_model.dart';
import '../../data/models/cat_breed_model.dart';
import '../../domain/use_cases/get_cat_image_use_case.dart';
import '../../domain/use_cases/get_cats_breeds_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCatsBreedsUseCase _getCatsBreedsUseCase;
  final GetCatsImageUseCase _getCatsImageUseCase;

  HomeCubit(
    this._getCatsBreedsUseCase,
    this._getCatsImageUseCase,
  ) : super(HomeState(
          isLoading: true,
          cats: [],
        ));

  Future<void> getCatsBreeds() async {
    final response = await _getCatsBreedsUseCase.call();

    response.fold(
      (l) {
        updateLoading(false);
      },
      (r) {
        _setCats(r);
        updateLoading(false);
      },
    );
  }

  void selectOneCat(CatBreedsModel cat) {
    emit(
      state.copyWith(
        selectedCat: cat,
      ),
    );
  }

  void _setCats(List<CatBreedsModel> cats) {
    emit(
      state.copyWith(
        cats: cats,
      ),
    );
  }

  Future<void> getCatImage({
    required CatBreedsModel cat,
  }) async {
    debugPrint("entrando a la funcion getCatImage ${cat.name}");

    final response = await _getCatsImageUseCase.call(
      catId: cat.id,
    );

    return response.fold(
      (l) {},
      (CatImageModel r) {
        debugPrint("llamando funcion updateCat ${cat.name}");
        updateCat(
          cat.copyWith(
            image: r,
            isImageLoad: true,
          ),
        );
      },
    );
  }

  void updateCat(CatBreedsModel cat) {
    debugPrint("entrando a la funcion updateCat ${cat.name}");
    final List<CatBreedsModel> catsAux = List.from(state.cats);

    final indexOfCat = state.cats.indexWhere(
      (element) => element.id == cat.id,
    );

    catsAux[indexOfCat] = cat;
    if (indexOfCat != -1) {
      debugPrint("entrando al if de la funcion updateCat ${cat.name} ");
      emit(
        state.copyWith(
          cats: catsAux,
        ),
      );
    }
    debugPrint("saliendo a la funcion updateCat ${cat.name}");
  }

  void updateLoading(bool isLoading) {
    emit(
      state.copyWith(
        isLoading: isLoading,
      ),
    );
  }
  // Future<void> _setandFetchCats(List<CatBreedsModel> cats) async {
  //   List<CatBreedsModel> catsAux = [];
  //   for (var cat in cats) {
  //     try {
  //       // Realizar la consulta para obtener la imagen del gato
  //       CatImageModel catImage = await getCatImage(cat: cat);

  //       catsAux.add(
  //         cat.copyWith(
  //           isImageLoad: true,
  //           image: catImage,
  //         ),
  //       );
  //     } catch (e) {
  //       catsAux.add(
  //         cat.copyWith(
  //           isImageLoad: true,
  //           image: null,
  //         ),
  //       );
  //     }
  //   }

  //   emit(
  //     state.copyWith(
  //       cats: catsAux,
  //     ),
  //   );
  // }
}
