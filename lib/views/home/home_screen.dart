import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/home_controller.dart';
import '../../views/common.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(_onScroll); // Attach the scroll listener
    _searchController = TextEditingController();

    // Fetch the initial set of movies when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeController = context.read<HomeController>();
      homeController.fetchMovies();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Trigger loading more movies when the user reaches the bottom
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final homeController = context.read<HomeController>();
      homeController.loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeController = context.watch<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: homeController.searchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    homeController.clearSearch();
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (query) => homeController.searchMovies(query),
            ),
          ),
        ),
      ),
      body: homeController.isLoading && homeController.filteredMovies.isEmpty
          ? const LoadingIndicator()
          : homeController.errorMessage.isNotEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              homeController.errorMessage,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => homeController.fetchMovies(),
              child: const Text('Retry'),
            ),
          ],
        ),
      )
          : ListView.builder(
        controller: _scrollController,
        itemCount: homeController.filteredMovies.length +
            (homeController.isLoading ? 1 : 0), // Add an extra for the loading indicator
        itemBuilder: (context, index) {
          if (index == homeController.filteredMovies.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final movie = homeController.filteredMovies[index];
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
              Navigator.pushNamed(context, '/movie-details',
                  arguments: movie);
            },
          );
        },
      ),
    );
  }
}
