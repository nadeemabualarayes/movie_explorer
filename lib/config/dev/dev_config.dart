import 'package:movie_explorer/config/config.dart';

/// Dev.
class DevAppConfig extends AppConfig {
  const DevAppConfig();

  @override
  String endpoint() {
    return 'https://api.themoviedb.org/3/';
  }

  @override
  String apiKey() {
    return 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNDFiYzI4NzE3NTVmZjVjMTE4ZWE0YmJjY2FmNTY2ZiIsIm5iZiI6MTczMzIzNDg4NC43OTQsInN1YiI6IjY3NGYxMGM0YWY4OWVkNzYyMzdkZmVmMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vEiUL9ayfFSH0zOoGSNHDLuR5foykrxCws-k26qnF18';
  }


}
