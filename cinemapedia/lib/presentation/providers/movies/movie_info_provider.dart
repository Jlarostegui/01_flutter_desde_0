import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final moviesRepository = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovie: moviesRepository.getMovieById);
});

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  MovieMapNotifier({required this.getMovie}) : super({});

  final GetMovieCallback getMovie;

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    final Movie movie = await getMovie(movieId);
    state = {...state, movieId: movie};
  }
}
