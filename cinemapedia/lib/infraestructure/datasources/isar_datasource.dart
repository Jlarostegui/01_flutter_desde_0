import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

class IsarDataSource extends LocalStorageDataSource {
  late Future<Isar> db;

  IsarDataSource() {
    db = openDb();
  }

  Future<Isar> openDb() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema],
          directory: dir.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int id) async {
    final isar = await db;
    final Movie? isFavoriteMovie =
        await isar.movies.filter().idEqualTo(id).findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    final isar = await db;
    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final Movie? favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null) {
      isar.writeTxnSync(() => {
            isar.movies.deleteAllSync([favoriteMovie.isarId ?? 0])
          });
      return;
    }
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }
}
