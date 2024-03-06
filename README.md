    # Movie Catalog App

Welcome to the Movie Catalog App! This app allows users to browse and search for movies, view detailed information about each movie, mark movies as favorites, and view their favorite movies separately.

## Features

### Movie List Screen

- Display a list of popular movies.
- Each movie item shows the movie poster, title, and release year.
- Users can search for movies based on the movie title.

### Movie Detail Screen

- Detailed information about the selected movie.
- Displays the movie poster, title, release year, rating, and a brief overview.
- Includes a button to mark/unmark the movie as a favorite.

### Favorites Screen

- Displays a list of favorite movies.
- Users can see the movies they marked as favorites on the Movie Detail Screen.
- Favorite movies are saved locally and persist even when the app is closed.

### API Integration

- Utilizes a public movie API (e.g., The Movie Database API) to fetch movie data.
- Makes API calls to retrieve the list of popular movies and detailed information for each movie.
- Handles API responses gracefully, including loading indicators and error messages.

### UI/UX Considerations

- Implements a clean and intuitive user interface.
- Focuses on user experience, including smooth transitions, animations, and loading indicators.

## Getting Started

1. Clone this repository to your local machine.
2. Set up Flutter on your machine if you haven't already.
3. Run `flutter pub get` to install dependencies.
4. Replace API_KEY in the code with your API key from [The Movie Database API](https://www.themoviedb.org/documentation/api).
5. Run the app on an emulator or a physical device using `flutter run`.

## Screenshots

![Movie List Screen](screenshots/movie_list_screen.png)
![Movie Detail Screen](screenshots/movie_detail_screen.png)
![Favorites Screen](screenshots/favorites_screen.png)

## Video Demo

[Watch the video demo](https://example.com) to see the app in action.

## Contributing

Contributions are welcome! If you have any suggestions or find any issues, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
