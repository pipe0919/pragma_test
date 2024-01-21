import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_pragma_app/src/core/inyeccion_dependency/injection_dependency.dart';

import '../../data/models/cat_breed_image_model.dart';
import '../cubit/home_cubit.dart';
import '../widgets/cat_info_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

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
                : _body(),
          );
        },
      ),
    );
  }

  Widget _body() {
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
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.cats.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<CatImageModel>(
                      key: UniqueKey(),
                      future:
                          _homeCubit.getCatImage(catId: state.cats[index].id),
                      builder:
                          (context, AsyncSnapshot<CatImageModel> snapshot) {
                        return CatInfoWidget(
                          cat: state.cats[index],
                          homeCubit: _homeCubit,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
