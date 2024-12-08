import 'package:flutter/material.dart';
import 'package:movie_explorer/core/services/api/app_repo.dart';
import '../models/movie.dart';

class HomeController with ChangeNotifier {
  List<Movie> movies = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  String errorMessage = '';
  int currentPage = 1;
  bool hasMore = true;

  Future<void> fetchMovies({int page = 1}) async {
    if (isLoading || isLoadingMore) return;

    page == 1 ? isLoading = true : isLoadingMore = true;
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
        currentPage = page;
        errorMessage = '';
      }
    } catch (e) {
      errorMessage = 'Failed to load movies. Please try again.';
    } finally {
      isLoading = false;
      isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> loadNextPage() async {
    if (hasMore) {
      await fetchMovies(page: currentPage + 1);
    }
  }
}
