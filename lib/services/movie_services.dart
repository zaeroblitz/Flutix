part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page';

    client ??= http.Client();

    var response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List results = data['results'];

    return results.map((result) => Movie.fromJson(result)).toList();
  }

  static Future<MovieDetail> getDetails(Movie movie,
      {int movieID, http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/${movieID ?? movie.id}?api_key=$apiKey&language=en-US';

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    List genres = (data as Map<String, dynamic>)['genres'];
    String language;

    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'ja':
        language = 'Japanese';
        break;
      case 'ko':
        language = 'Korean';
        break;
      case 'en':
        language = 'English';
        break;
      case 'id':
        language = 'Indonesian';
        break;
      default:
        language =
            (data as Map<String, dynamic>)['original_language'].toString();
        break;
    }

    return movieID != null
        ? MovieDetail(Movie.fromJson(data),
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList(),
            language: language)
        : MovieDetail(movie,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList(),
            language: language);
  }

  static Future<List<Credit>> getCredits(int movieId,
      {http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey&language=en-US';

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    return ((data as Map<String, dynamic>)['cast'] as List)
        .map((e) => Credit(
            name: (e as Map<String, dynamic>)['name'],
            profilePath: (e as Map<String, dynamic>)['profile_path']))
        .take(8)
        .toList();
  }
}
