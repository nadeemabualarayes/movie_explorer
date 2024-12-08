import 'package:flutter/material.dart';
import 'package:movie_explorer/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = context.watch<HomeController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: homeController.favoriteMovies.isEmpty
          ? const Center(child: Text('No favorites added.'))
          : ListView.builder(
        itemCount: homeController.favoriteMovies.length,
        itemBuilder: (context, index) {
          final movie = homeController.favoriteMovies[index];
          return ListTile(
            leading: Image.network(
              "https://image.tmdb.org/t/p/w200${movie.posterPath}",
              width: 50,
              height: 75,
              fit: BoxFit.cover,
            ),
            title: Text(movie.title),
            subtitle: Text("Rating: ${movie.rating}"),
            onTap: () {
              Navigator.pushNamed(context, '/movie-details', arguments: movie);
            },
          );
        },
      ),
    );
  }
}
