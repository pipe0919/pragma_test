part of 'home_cubit.dart';

class HomeState {
  final bool isLoading;

  final List<CatBreedsModel> cats;
  final List<CatBreedsModel> filterCats;
  final CatBreedsModel? selectedCat;
  HomeState({
    required this.isLoading,
    required this.cats,
    required this.filterCats,
    this.selectedCat,
  });

  HomeState copyWith({
    bool? isLoading,
    List<CatBreedsModel>? cats,
    List<CatBreedsModel>? filterCats,
    CatBreedsModel? selectedCat,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      cats: cats ?? this.cats,
      selectedCat: selectedCat ?? this.selectedCat,
      filterCats: filterCats ?? this.filterCats,
    );
  }
}
