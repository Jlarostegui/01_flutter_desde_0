import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    final List<Movie> movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie> favoritesMovies =
        ref.read(favoriteMoviesProvider).values.toList();

    if (favoritesMovies.isEmpty) {
      return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.favorite_border_sharp, size: 60),
              const Text(
                'No tienes Favoritos',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'No tienes peliculas favoritas',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              FilledButton.tonal(
                  onPressed: () => context.go('/home/0'),
                  child: const Text('inicio'))
            ]),
      );
    }
    return Scaffold(
      body: MovieMasonry(
        movies: favoritesMovies,
        loadNextPage: () {},
      ),
    );
  }
}
