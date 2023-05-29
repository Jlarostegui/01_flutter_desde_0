import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String theMovieDbKey =
      dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay api key';
  static String baseUrl = 'https://api.themoviedb.org/3/';
}

enum UrlMovies {
  nowPlaying('movie/now_playing'),
  popular('movie/popular'),
  topRated('movie/top_rated'),
  upComing('movie/upcoming'),
  movie('movie/'),
  credits('/credits'),
  path('https://image.tmdb.org/t/p/w500'),
  searchMovie('search/movie');

  const UrlMovies(this.value);
  final String value;
}
