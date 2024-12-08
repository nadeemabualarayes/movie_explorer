import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_explorer/config/config.dart';

/// Prod.
class ProdAppConfig extends AppConfig {
  const ProdAppConfig();

  @override
  String endpoint() {
    //return dotenv.env['API_BASE_URL'] ?? '';
    return 'https://api.themoviedb.org/3/';
  }

  @override
  String apiKey() {
    //return dotenv.env['API_KEY'] ?? '';
    return 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNDFiYzI4NzE3NTVmZjVjMTE4ZWE0YmJjY2FmNTY2ZiIsIm5iZiI6MTczMzIzNDg4NC43OTQsInN1YiI6IjY3NGYxMGM0YWY4OWVkNzYyMzdkZmVmMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vEiUL9ayfFSH0zOoGSNHDLuR5foykrxCws-k26qnF18';
  }
}
