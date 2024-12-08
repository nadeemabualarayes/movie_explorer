import 'package:movie_explorer/core/services/api/api_executor_impl.dart';
import 'package:movie_explorer/models/movie.dart';

abstract class ApiExecutor {
  static ApiExecutor? _instance;

  static ApiExecutor getInstance() {
    return _instance ??= ApiExecutorImpl();
  }

  ApiExecutor();

  Future<List<Movie>> fetchMovies(int page);
}
