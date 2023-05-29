import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:flutter/material.dart';

class MoviesSlideShow extends StatelessWidget {
  const MoviesSlideShow({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        itemCount: movies.length,
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        itemBuilder: (context, index) => _Sllide(
          movie: movies[index],
        ),
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary,
          ),
        ),
      ),
    );
  }
}

class _Sllide extends StatelessWidget {
  const _Sllide({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10),
        )
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) =>
                loadingProgress != null
                    ? const DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black12),
                      )
                    : FadeIn(
                        child: child,
                      ),
          ),
        ),
      ),
    );
  }
}
