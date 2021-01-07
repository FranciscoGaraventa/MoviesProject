abstract class BaseUrl {
  static const moviePath = 'https://image.tmdb.org/t/p/w500';
  static const backdropPath = 'https://image.tmdb.org/t/p/w780';
  static const trendingMovies = 'https://api.themoviedb.org/3/trending/movie/week?api_key=';
  static const genresMovies = 'https://api.themoviedb.org/3/genre/movie/list?api_key=';
  static const moviesByGenreBasicUrl = 'https://api.themoviedb.org/3/discover/movie?api_key=';
  static const moviesWithGenres = '&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=';
}
