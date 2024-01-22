import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app.dart';

import '../../features/home/data/models/cat_breed_model.dart';
import '../../features/home/ui/screens/cat_detail_screen.dart';
import '../../features/home/ui/screens/home_screen.dart';

// Main routes class
mixin AppRouter on State<MyApp> {
  GoRouter getRouter() {
    return _router;
  }

  static final GoRouter _router = GoRouter(
    initialLocation: HomeScreen.routeName,
    routes: [
      GoRoute(
        path: HomeScreen.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: HomeScreen(),
        ),
      ),
      GoRoute(
        path: CatDetailScreen.routeName,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final name = state.extra! as CatBreedsModel;
          return MaterialPage(
            child: CatDetailScreen(
              cat: name,
            ),
          );
        },
      ),
    ],
  );
}
