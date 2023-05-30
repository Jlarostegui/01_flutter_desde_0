import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upCommingMovieProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final bool initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return FullScreenLoader();
    final List<Movie> nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final List<Movie> slideShowMovies = ref.watch(moviesSlideShowProvider);
    final List<Movie> popularMovies = ref.watch(popularMoviesProvider);
    final List<Movie> topRatedMovies = ref.watch(topRatedMoviesProvider);
    final List<Movie> upCommingMovies = ref.watch(upCommingMovieProvider);
    return Visibility(
      visible: !initialLoading,
      child: CustomScrollView(slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: CustomAppBar(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                MoviesSlideShow(movies: slideShowMovies),
                MoviesHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subtitle: '21/02/23',
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage(),
                ),
                MoviesHorizontalListview(
                  movies: upCommingMovies,
                  title: 'Proximamente',
                  subtitle: '21/02/23',
                  loadNextPage: () =>
                      ref.read(upCommingMovieProvider.notifier).loadNextPage(),
                ),
                MoviesHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  loadNextPage: () =>
                      ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),
                MoviesHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejor calificadas',
                  subtitle: '21/02/23',
                  loadNextPage: () =>
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                ),
                const SizedBox(
                  height: 10,
                )

                // Expanded(
                //   child: ListView.builder(
                //     itemCount: nowPlayingMovies.length,
                //     itemBuilder: (context, index) => ListTile(
                //       title: Text(nowPlayingMovies[index].title),
                //     ),
                //   ),
                // ),
              ],
            );
          }, childCount: 10),
        )
      ]),
    );
  }
}
