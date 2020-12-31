class GenreResult {
  int _id;
  String _name;

  GenreResult(result) {
    _id = result['id'];
    _name = result['name'];
  }

  int get id => _id;

  String get name => _name;
}
