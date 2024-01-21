part of 'home_cubit.dart';

class HomeState {
  final bool isLoading;
  final List<CatBreedsModel> cats;
  final CatBreedsModel? selectedCat;
  HomeState({
    required this.isLoading,
    required this.cats,
    this.selectedCat,
  });

  HomeState copyWith({
    bool? isLoading,
    List<CatBreedsModel>? cats,
    CatBreedsModel? selectedCat,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      cats: cats ?? this.cats,
      selectedCat: selectedCat ?? this.selectedCat,
    );
  }
}
