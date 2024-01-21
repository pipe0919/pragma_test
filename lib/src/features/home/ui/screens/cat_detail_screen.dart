import 'package:flutter/material.dart';

class CatDetailScreen extends StatelessWidget {
  static const String routeName = '/cat-detail';
  const CatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('cat detail screen'),
      ),
      body: const Center(
        child: Text('Hello World2'),
      ),
    );
  }
}
