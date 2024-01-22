import 'package:shared_preferences/shared_preferences.dart';

/// The [PreferenciasUsuario] class manages user preferences using SharedPreferences.
class PreferenciasUsuario {
  /// Singleton instance of [PreferenciasUsuario].
  static final PreferenciasUsuario _instancia = PreferenciasUsuario.internal();

  /// Private constructor for singleton pattern.
  PreferenciasUsuario.internal();

  /// Factory constructor to get the singleton instance of [PreferenciasUsuario].
  factory PreferenciasUsuario() {
    return _instancia;
  }

  /// SharedPreferences instance to store and retrieve preferences.
  static late SharedPreferences _prefs;

  /// Initializes SharedPreferences.
  static iniciarPreferencias() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Clears all preferences.
  limpiar() async {
    _prefs.clear();
  }

  /// Gets the catList from preferences.
  List<String> get catList {
    return _prefs.getStringList('catList') ?? [];
  }

  /// Sets the catList in preferences.
  set catList(List<String> value) {
    _prefs.setStringList('catList', value);
  }
}
