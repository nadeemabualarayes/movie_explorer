import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_explorer/core/services/api/app_repo.dart';
import 'package:movie_explorer/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeController with ChangeNotifier {
  List<Movie> movies = [];
  List<Movie> filteredMovies = [];
  bool isLoading = false;
  String errorMessage = '';
  int currentPage = 1;
  bool hasMore = true;
  String searchQuery = '';

  List<Movie> favoriteMovies = [];

  Future<void> fetchMovies({int page = 1}) async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      // Assuming this is how you fetch your movies
      final response = await AppRepo.instance().fetchMovies(page);
      if (response.isEmpty) {
        hasMore = false;
      } else {
        if (page == 1) {
          movies = response;
        } else {
          movies.addAll(response);
        }
        filteredMovies = movies;
        errorMessage = '';
      }
    } catch (e) {
      errorMessage = 'Failed to load movies. Please try again.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void loadNextPage() {
    if (isLoading || !hasMore) return;
    currentPage++;
    fetchMovies(page: currentPage);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString('favorites') ?? '[]';
    final List<dynamic> favoritesList = json.decode(favoritesJson);
    favoriteMovies = favoritesList.map((item) => Movie.fromJson(item)).toList();
    notifyListeners();
  }

  Future<void> toggleFavorite(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final movieIndex =
        favoriteMovies.indexWhere((favMovie) => favMovie.id == movie.id);

    if (movieIndex == -1) {
      favoriteMovies.add(movie);
    } else {
      favoriteMovies.removeAt(movieIndex);
    }

    final favoriteMoviesJson = json
        .encode(favoriteMovies.map((favMovie) => favMovie.toJson()).toList());
    await prefs.setString('favorites', favoriteMoviesJson);
    notifyListeners();
  }

  void searchMovies(String query) {
    searchQuery = query;
    if (query.isEmpty) {
      filteredMovies = movies;
    } else {
      filteredMovies = movies
          .where((movie) =>
              movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    searchQuery = '';
    filteredMovies = movies;
    notifyListeners();
  }
}
