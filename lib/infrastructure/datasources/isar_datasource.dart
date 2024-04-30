import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDataSource extends LocalStorageDatasource {
  late Future<Isar>
      db; // la apertura de datos no es sincrona, tenemos que esperarr que la base de datos ese lista para realizar conecciones

  IsarDataSource() {
    db = openDb();
  }

  Future<Isar> openDb() async {
    final dir = await getApplicationDocumentsDirectory();

    //Preguntando si no hay instancias
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema],
          directory: dir.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMoviewFavorite(int moviewId) async  {
    final isar = await db;

    final Movie? isFavoriteMovie = await isar.movies
        .filter()
        .idEqualTo(moviewId)
        .findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;

    return isar.movies.where()
        .offset(offset)
        .limit(limit)
        .findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {

    final isar = await db;

    final favoriteMovie = await isar.movies
        .filter()
        .idEqualTo(movie.id)
        .findFirst();

    if ( favoriteMovie != null ) {
      // Borrar
      isar.writeTxnSync(() => isar.movies.deleteSync( favoriteMovie.isarId! ));
      return;
    }

    // Insertar
    isar.writeTxnSync(() => isar.movies.putSync(movie));

  }
}
