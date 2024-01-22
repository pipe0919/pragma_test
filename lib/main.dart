import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'src/core/inyeccion_dependency/injection_dependency.dart';
import 'src/core/shared_prefences/shared_preferences.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Dependencies().setup();
  await PreferenciasUsuario.iniciarPreferencias();

  runApp(const MyApp());
}
