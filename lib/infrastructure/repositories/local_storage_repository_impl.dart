import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {

  final LocalStorageDatasource dataSource; // el data source peude ser de fireebase, o lo que nos cante

  LocalStorageRepositoryImpl( this.dataSource);

  @override
  Future<bool> isMoviewFavorite(int moviewId) {
    return dataSource.isMoviewFavorite(moviewId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return dataSource.loadMovies(limit: limit, offset: offset);

  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return dataSource.toggleFavorite(movie);
  }
  
}