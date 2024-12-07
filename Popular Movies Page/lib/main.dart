//Make sure you replace the API key with your API key created in OMDB Website
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieListPage(),
    );
  }
}

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  List<String> _movieIds = [
    'tt15239678', 'tt12037194', 'tt22022452', 'tt30321095', 'tt1160419',
    'tt1016150', 'tt1037070', 'tt5113044', 'tt6263850', 'tt5113046',
    'tt10648342', 'tt5113048', 'tt5113050', 'tt5113052', 'tt5113054',
    'tt5113056', 'tt5113058', 'tt5113060', 'tt5113062', 'tt5113064',
    'tt5113066', 'tt5113068', 'tt5113070', 'tt5113072', 'tt5113074',
    'tt5113076', 'tt5113078', 'tt5113080', 'tt5113082', 'tt5113084',
    'tt5113086', 'tt5113088', 'tt5113090', 'tt5113092', 'tt5113094',
    'tt5113096', 'tt5113098', 'tt5113100', 'tt5113102', 'tt5113104',
    'tt5113106', 'tt5113108', 'tt5113110', 'tt5113112', 'tt5113114',
    'tt5113116', 'tt5113118', 'tt5113120', 'tt5113122', 'tt5113124',
    'tt5113126', 'tt5113128', 'tt5113130', 'tt5113132', 'tt5113134',
    'tt5113136', 'tt5113138', 'tt5113140', 'tt5113142', 'tt5113144',
    'tt5113146', 'tt5113148', 'tt5113150', 'tt5113152', 'tt5113154',
    'tt5113156', 'tt5113158', 'tt5113160', 'tt5113162', 'tt5113164',
    'tt5113166', 'tt5113168', 'tt5113170', 'tt5113172', 'tt5113174',
    'tt5113176', 'tt5113178', 'tt5113180', 'tt5113182', 'tt5113184',
    'tt5113186', 'tt5113188', 'tt5113190', 'tt5113192', 'tt5113194',
    'tt5113196', 'tt5113198', 'tt5113200', 'tt5113202', 'tt5113204',
    'tt5113206', 'tt5113208', 'tt5113210', 'tt5113212', 'tt5113214',
    'tt5113216', 'tt5113218', 'tt5113220', 'tt5113222', 'tt5113224'
  ];

  List<dynamic> _movies = [];
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadMovies(); // Load the movies on initialization
  }

  // Function to fetch movies by IMDb ID using OMDB API
  Future<void> _fetchMovieById(String imdbId) async {
    final String apiKey = 'Replace this with your API Key'; // Your OMDB API key

    try {
      final response = await http.get(Uri.parse(
          'https://www.omdbapi.com/?apikey=$apiKey&i=$imdbId'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print("API response for $imdbId: ${response.body}");

        if (data['Response'] == 'True') {
          setState(() {
            _movies.add(data); // Add the movie data to the list
          });
        } else {
          print('Error fetching data for IMDb ID: $imdbId. Error: ${data['Error']}');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid API Key');
      } else {
        throw Exception('Failed to load movie. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('API error: $error');
      setState(() {
        _hasError = true;
        _errorMessage = error.toString();
      });
    }
  }

  // Function to load movies sequentially
  Future<void> _loadMovies() async {
    setState(() {
      _isLoading = true; // Set loading state
    });

    for (var imdbId in _movieIds) {
      await _fetchMovieById(imdbId); // Fetch each movie one by one
    }

    setState(() {
      _isLoading = false; // Reset loading state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Movies'),
      ),
      body: _hasError
          ? Center(
        child: Text(
          'Failed to load movies. Error: $_errorMessage',
          style: TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      )
          : _movies.isEmpty && !_isLoading
          ? Center(child: Text("No movies to display"))
          : ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          final movie = _movies[index];
          return MovieTile(movie: movie);
        },
      ),
    );
  }
}

class MovieTile extends StatelessWidget {
  final dynamic movie;

  MovieTile({required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(10),
      leading: movie['Poster'] != 'N/A'
          ? Image.network(movie['Poster'])
          : Icon(Icons.movie),
      title: Text(
        movie['Title'],
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Year: ${movie['Year']}\nIMDB Rating: ${movie['imdbRating']}'),
    );
  }
}
