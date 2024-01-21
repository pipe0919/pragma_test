import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/cat_breed_image_model.dart';
import '../../data/models/cat_breed_model.dart';
import '../cubit/home_cubit.dart';

class CatInfoWidget extends StatelessWidget {
  const CatInfoWidget({
    super.key,
    required this.homeCubit,
    required this.cat,
  });
  final CatBreedsModel cat;
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: homeCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return FutureBuilder<CatImageModel>(
          future: homeCubit.getCatImage(catId: cat.id),
          builder: (context, AsyncSnapshot<CatImageModel> snapshot) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        cat.name,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Más...',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (snapshot.hasData)
                    CachedNetworkImage(
                      cacheKey: cat.id,
                      imageUrl: snapshot.data!.url,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 350,
                      ),
                      placeholder: (context, url) => Container(
                        height: 350,
                        width: 250,
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 350,
                        width: 250,
                        child: Icon(Icons.error),
                      ),
                    )
                  else
                    const CircularProgressIndicator(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          cat.origin,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Inteligencia: ${cat.intelligence}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
