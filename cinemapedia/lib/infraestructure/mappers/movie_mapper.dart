import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/infraestructure/models/models.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/movie_details.dart';

class MovieMapper {
  static Movie movieDbToentity(MovieMovieDb movieDb) => Movie(
        adult: movieDb.adult,
        backdropPath: movieDb.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500${movieDb.backdropPath}'
            : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
        genreIds: movieDb.genreIds.map((id) => id.toString()).toList(),
        id: movieDb.id,
        originalLanguage: movieDb.originalLanguage,
        originalTitle: movieDb.originalTitle,
        overview: movieDb.overview,
        popularity: movieDb.popularity,
        posterPath: movieDb.posterPath != ''
            ? '${UrlMovies.path.value}${movieDb.posterPath}'
            : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
        releaseDate: movieDb.releaseDate,
        title: movieDb.title,
        video: movieDb.video,
        voteAverage: movieDb.voteAverage,
        voteCount: movieDb.voteCount,
      );

  static Movie movieDetailsToentity(MovieDetails movie) => Movie(
        adult: movie.adult,
        backdropPath: movie.backdropPath != ''
            ? '${UrlMovies.path.value}${movie.backdropPath}'
            : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
        genreIds: movie.genres.map((genre) => genre.name.toString()).toList(),
        id: movie.id,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        overview: movie.overview,
        popularity: movie.popularity,
        posterPath: movie.posterPath != ''
            ? '${UrlMovies.path.value}${movie.posterPath}'
            : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
        releaseDate: movie.releaseDate,
        title: movie.title,
        video: movie.video,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
      );

}
