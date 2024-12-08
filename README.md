---

---

## Movie Explorer 🎥

Explore and discover movies using a public movie API (e.g., TMDB). This app is built with Flutter and follows the **MVC architecture**. It uses `provider` for state management, `dio` for API calls, and environment variables to securely store API keys.

## Features
- View a list of popular movies.
- Search for movies by title.
- Infinite scrolling with pagination.
- Pull-to-refresh functionality.
- Mark movies as favorites and view them on a separate screen.

## Requirements
- Flutter SDK (>= 3.0.0)
- Dart SDK (>= 2.17.0)
- Android Studio / Xcode (for running on devices or emulators)
- An active internet connection

---

## Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/nadeemabualarayes/movie_explorer.git
cd movie-explorer
```

### 2. Install Dependencies
Run the following command in the project directory to fetch all the necessary dependencies:
```bash
flutter pub get
```

### 3. Run the App
```bash
flutter run
```


### 4. Configure API
Make sure you have set up the necessary API configurations in the `AppRepo` class. For example:
- Add your API key or base URL if required.
- Check the `fetchMovies` method in `AppRepo`.

---

## Folder Structure
- **`controllers/`**: Contains controllers like `HomeController` to manage state and logic.
- **`models/`**: Includes data models like `Movie`.
- **`views/`**: Houses UI components and screens (e.g., HomeScreen, MovieDetailsScreen, FavoritesScreen).
- **`core/`**: Contains shared services like API handling.
---