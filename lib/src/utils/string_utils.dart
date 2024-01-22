class StringUtils {
  static String getCatImage([String? id]) {
    if (id == null) {
      return 'https://as1.ftcdn.net/v2/jpg/01/14/81/86/500_F_114818612_D26GJxxdrZzuZZ2x8SWNhHFnDHxjCD3F.jpg';
    }
    return "https://cdn2.thecatapi.com/images/$id.jpg";
  }
}
