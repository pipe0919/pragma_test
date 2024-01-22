import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/string_utils.dart';
import '../../data/models/cat_breed_model.dart';
import '../screens/cat_detail_screen.dart';

class CatInfoWidget extends StatelessWidget {
  const CatInfoWidget({
    super.key,
    required this.cat,
  });
  final CatBreedsModel cat;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(CatDetailScreen.routeName, extra: cat);
      },
      child: Container(
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
                Hero(
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
                errorWidget: (_, __, ___) => Container(
                  height: 350,
                  width: 250,
                  child: Image.network(StringUtils.getCatImage()),
                ),
              ),
            ),
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
      ),
    );
  }
}
