# Popular Movies App 🎥

A Flutter app that displays a list of popular movies using data fetched from the OMDB API. This app fetches movie details based on IMDb IDs and displays key information, including posters, titles, release years, and IMDb ratings.

## Features
- Displays movie information including:
  - Title  
  - Release Year  
  - IMDb Rating  
  - Poster  
- Handles loading and error states.  
- Clean and responsive UI using Flutter widgets.  

## Prerequisites
- **Flutter SDK**: Ensure you have the Flutter SDK installed.  
- **OMDB API Key**: Sign up at [OMDB API](https://www.omdbapi.com/) and generate your API key.

## How to Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/popular-movies.git
   cd popular-movies
Get the dependencies:

bash
Copy code
flutter pub get
Replace the API Key: Open the main.dart file and replace the placeholder API key with your OMDB API key:

dart
Copy code
final String apiKey = 'Replace this with your API Key';
Run the app:

bash
Copy code
flutter run
Project Structure
main.dart: Contains the app's entry point and routes.
MovieListPage: The main page that fetches and displays the movie list.
MovieTile: A widget to display individual movie details.
