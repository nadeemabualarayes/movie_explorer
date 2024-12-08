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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeController = context.read<HomeController>();
      homeController.fetchMovies();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
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
      appBar: AppBar(title: const Text("Movies")),
      body: homeController.isLoading
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
        itemCount: homeController.movies.length +
            (homeController.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == homeController.movies.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final movie = homeController.movies[index];
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
