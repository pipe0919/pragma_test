import 'package:flutter/material.dart';

import 'app.dart';
import 'src/core/inyeccion_dependency/injection_dependency.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Dependencies().setup();
  runApp(const MyApp());
}
