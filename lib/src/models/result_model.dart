import '../resources/base_url.dart';

class Result {
  List<int> _genreIds = [];
  String _originalLanguage;
  String _originalTitle;
  String _posterPath;
  bool _video;
  double _voteAverage;
  int _id;
  String _overview;
  String _releaseDate;
  int _voteCount;
  String _title;
  bool _adult;
  String _backdropPath;
  double _popularity;
  String _mediaType;

  Result(result) {
    for (int i = 0; i < result['genre_ids'].length; i++) {
      _genreIds.add(result['genre_ids'][i]);
    }
    _originalLanguage = result['original_language'];
    _originalTitle = result['original_title'];
    _posterPath = result['poster_path'] != null
        ? BaseUrl.moviePath + result['poster_path']
        : null;
    _video = result['video'];
    _voteAverage = double.tryParse(result['vote_average'].toString());
    _id = result['id'];
    _overview = result['overview'];
    _releaseDate = result['release_date'];
    _voteCount = result['vote_count'];
    _title = result['title'];
    _adult = result['adult'];
    _backdropPath = result['backdrop_path'] != null
        ? BaseUrl.backdropPath + result['backdrop_path']
        : null;
    _popularity = result['popularity'];
    _mediaType = result['media_type'];
  }

  List<int> get genreIds => _genreIds;

  String get originalLanguage => _originalLanguage;

  String get originalTitle => _originalTitle;

  String get posterPath => _posterPath;

  bool get video => _video;

  double get voteAverage => _voteAverage;

  int get id => _id;

  String get overview => _overview;

  String get releaseDate => _releaseDate;

  int get voteCount => _voteCount;

  String get title => _title;

  bool get adult => _adult;

  String get backdropPath => _backdropPath;

  double get popularity => _popularity;

  String get mediaType => _mediaType;
}
