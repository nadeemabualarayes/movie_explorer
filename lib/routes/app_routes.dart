import 'package:flutter/material.dart';
import '../views/home/home_screen.dart';
import '../views/movie_details/movie_details_screen.dart';
import '../models/movie.dart';

class AppRoutes {
  static const String home = '/';
  static const String movieDetails = '/movie-details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case movieDetails:
        final movie = settings.arguments as Movie;
        return MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: movie));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text("Page not found"))),
        );
    }
  }
}
