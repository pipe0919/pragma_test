import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_pragma_app/src/utils/string_utils.dart';

import '../../data/models/cat_breed_model.dart';

class CatDetailScreen extends StatelessWidget {
  static const String routeName = '/cat-detail';
  const CatDetailScreen({
    super.key,
    required this.cat,
  });
  final CatBreedsModel cat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Hero(
          tag: cat.name,
          child: Text(
            cat.name,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: Column(
        children: [
          Hero(
            tag: cat.id,
            child: CachedNetworkImage(
              cacheKey: cat.id,
              imageUrl: StringUtils.getCatImage(cat.referenceImageId),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                height: 350,
              ),
              placeholder: (_, __) => const SizedBox(
                height: 350,
                width: 250,
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (_, __, ___) => SizedBox(
                height: 350,
                width: 250,
                child: Image.network(StringUtils.getCatImage()),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.45,
            child: RawScrollbar(
              crossAxisMargin: 5,
              thumbColor: Colors.black45,
              scrollbarOrientation: ScrollbarOrientation.right,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cat.description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 25),
                      _fields('Country of origin: ', cat.origin),
                      const SizedBox(height: 20),
                      _fields('Intelligence: ', cat.intelligence.toString()),
                      const SizedBox(height: 20),
                      _fields('Adaptability: ', cat.adaptability.toString()),
                      const SizedBox(height: 20),
                      _fields('Life Span: ', cat.lifeSpan),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fields(String tiitle, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tiitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          description,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
