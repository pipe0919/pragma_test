import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_pragma_app/src/core/inyeccion_dependency/injection_dependency.dart';

import '../cubit/home_cubit.dart';
import '../widgets/cat_info_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _homeCubit;

  @override
  void initState() {
    _homeCubit = sl<HomeCubit>();
    _homeCubit.getCatsBreeds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _homeCubit,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text('Cat Breeds'),
            ),
            body: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _body(state),
          );
        },
      ),
    );
  }

  Widget _body(HomeState state) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          _builderOfCatsList(state)
        ],
      ),
    );
  }

  Expanded _builderOfCatsList(HomeState state) {
    print("llamando al _builderOfCatsList Aegean");
    return Expanded(
      child: ListView.builder(
        itemCount: state.cats.length,
        itemBuilder: (context, index) {
          if (state.cats[index].isImageLoad) {
            return CatInfoWidget(
              key: UniqueKey(),
              cat: state.cats[index],
            );
          } else {
            print(
                "llamando a la funcion getCatImage ${state.cats[index].name}");
            return FutureBuilder(
              future: state.cats[index].isImageLoad
                  ? Future.value(state.cats[index])
                  : _homeCubit.getCatImage(cat: state.cats[index]),
              builder: (_, __) => CatInfoWidget(
                key: UniqueKey(),
                cat: state.cats[index],
              ),
            );
          }
        },
      ),
    );
  }
}
