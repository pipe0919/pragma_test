import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/cat_breed_model.dart';
import '../../domain/use_cases/get_cats_breeds_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCatsBreedsUseCase _getCatsBreedsUseCase;

  HomeCubit(
    this._getCatsBreedsUseCase,
  ) : super(HomeState(
          isLoading: true,
          cats: [],
          filterCats: [],
        ));

  Future<void> getCatsBreeds() async {
    final response = await _getCatsBreedsUseCase.call();

    response.fold(
      (l) {
        updateLoading(false);
      },
      (r) {
        _setCats(r);
        _setInitialFilterCats(r);
        updateLoading(false);
      },
    );
  }

  void filterCats(String filter) {
    final cats = state.cats.where((cat) {
      return cat.name.toLowerCase().contains(filter.toLowerCase());
    }).toList();

    emit(
      state.copyWith(
        filterCats: cats,
      ),
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
        cats: List.unmodifiable(cats),
      ),
    );
  }

  void _setInitialFilterCats(List<CatBreedsModel> cats) {
    emit(
      state.copyWith(
        filterCats: cats,
      ),
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
