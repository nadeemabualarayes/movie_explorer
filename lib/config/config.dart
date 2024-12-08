import 'package:movie_explorer/config/dev/dev_config.dart';
import 'package:movie_explorer/config/prod/prod_config.dart';

const AppConfig kAppConfig = ProdAppConfig();

/// DevAppConfig
///
/// ProdAppConfig

abstract class AppConfig {
  const AppConfig();

  String endpoint();
  String apiKey();
}
