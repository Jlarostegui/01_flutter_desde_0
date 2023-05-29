import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) => MoviesNotifier(
    fetchMoreMovies: ref.watch(movieRepositoryProvider).getNowPlaying,
  ),
);

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) => MoviesNotifier(
    fetchMoreMovies: ref.watch(movieRepositoryProvider).getPopular,
  ),
);

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) => MoviesNotifier(
    fetchMoreMovies: ref.watch(movieRepositoryProvider).getTopRated,
  ),
);

final upCommingMovieProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) => MoviesNotifier(
    fetchMoreMovies: ref.watch(movieRepositoryProvider).getUpcoming,
  ),
);

typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  int currentPage = 0;
  bool isLoading = false;
  MovieCallBack fetchMoreMovies;

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
