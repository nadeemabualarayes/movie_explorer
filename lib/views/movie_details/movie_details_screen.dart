import 'package:flutter/material.dart';
import 'package:movie_explorer/models/movie.dart';
import 'package:provider/provider.dart';
import '../../controllers/home_controller.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final homeController = context.read<HomeController>();

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network("https://image.tmdb.org/t/p/w500${movie.posterPath}"),
              const SizedBox(height: 16),
              Text(movie.title, style: const TextStyle(fontSize: 24)),
              Text("Rating: ${movie.rating}",
                  style: const TextStyle(fontSize: 18)),
              Text(movie.title,
                  style:
                      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Release Date: ${movie.releaseDate}"),
              const SizedBox(height: 8),
              Text(movie.overview),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  homeController.toggleFavorite(movie);
                },
                child: Icon(
                  homeController.favoriteMovies.contains(movie)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: homeController.favoriteMovies.contains(movie)
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
