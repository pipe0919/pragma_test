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

  Future<CatImageModel> getCatImage({
    required String catId,
  }) async {
    final response = await _getCatsImageUseCase.call(
      catId: catId,
    );

    return response.fold(
      (l) {
        return CatImageModel(
          height: 0,
          id: '',
          url: '',
          width: 0,
        );
      },
      (CatImageModel r) {
        return r;
      },
    );
  }

  void updateLoading(bool isLoading) {
    emit(
      state.copyWith(
        isLoading: isLoading,
      ),
    );
  }
}
