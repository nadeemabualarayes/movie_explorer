import 'package:flutter/material.dart';
import 'package:movie_explorer/models/movie.dart';
import 'package:movie_explorer/views/favorites/favorites_screen.dart';
import 'package:movie_explorer/views/home/home_screen.dart';
import 'package:movie_explorer/views/movie_details/movie_details_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String movieDetails = '/movie-details';
  static const String fav = '/favorites';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case movieDetails:
        final movie = settings.arguments as Movie;
        return MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(movie: movie));
      case fav:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Page not found"))),
        );
    }
  }
}
