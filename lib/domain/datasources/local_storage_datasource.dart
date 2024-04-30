


import '../entities/movie.dart';

abstract class LocalStorageDatasource {
  Future<void> toggleFavorite( Movie movie );
  Future<bool> isMoviewFavorite( int moviewId );
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}