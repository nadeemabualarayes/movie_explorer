import 'package:movie_explorer/core/services/api/api_executor.dart';
import 'package:movie_explorer/models/movie.dart';

class AppRepo {
  static AppRepo? _instance;

  static AppRepo instance() => _instance ??= AppRepo._();

  AppRepo._();

  final ApiExecutor apiExecutor = ApiExecutor.getInstance();

  Future<List<Movie>> fetchMovies(int page) async {
    return await apiExecutor.fetchMovies(
      page,
    );
  }
}
