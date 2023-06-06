import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie> favoritesMovies =
        ref.read(favoriteMoviesProvider).values.toList();

    return Scaffold(
        body: ListView.builder(
      itemCount: favoritesMovies.length,
      itemBuilder: (context, index) {
        final Movie movie = favoritesMovies[index];
        return ListTile(
          title: Text(movie.title),
        );
      },
    ));
  }
}
