import 'package:movie_explorer/config/config.dart';
import 'package:movie_explorer/core/services/api/api_executor.dart';
import 'package:movie_explorer/core/services/dio/dio.dart';
import 'package:movie_explorer/core/services/dio/http_client.dart';
import 'package:movie_explorer/models/movie.dart';

class ApiExecutorImpl extends ApiExecutor {
  late DioClient client;

  ApiExecutorImpl() {
    client = DioClient(
      DioFactory.createDio(kAppConfig.endpoint()),
    );
  }

  @override
  Future<List<Movie>> fetchMovies(int page) async {
    final response =
        await client.get("movie/popular", queryParameters: {'page': page});
    return (response['results'] as List)
        .map((json) => Movie.fromJson(json))
        .toList();
  }
}
