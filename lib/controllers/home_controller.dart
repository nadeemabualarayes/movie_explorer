import 'package:flutter/material.dart';
import 'package:movie_explorer/core/services/api/app_repo.dart';
import '../models/movie.dart';

class HomeController with ChangeNotifier {
  List<Movie> movies = [];
  List<Movie> filteredMovies = [];
  bool isLoading = false;
  String errorMessage = '';
  int currentPage = 1;
  bool hasMore = true;
  String searchQuery = '';

  Future<void> fetchMovies({int page = 1}) async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
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
