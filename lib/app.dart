import 'package:flutter/material.dart'
    show StatefulWidget, State, Widget, MaterialApp, BuildContext;

import 'src/core/routes/routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AppRouter {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: getRouter(),
      title: 'Cat breeds',
    );
  }
}
