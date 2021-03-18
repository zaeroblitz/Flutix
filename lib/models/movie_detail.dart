part of 'models.dart';

class MovieDetail extends Movie {
  final List<String> genres;
  final String language;

  MovieDetail(Movie movie, {this.genres, this.language})
      : super(
            id: movie.id,
            title: movie.title,
            overview: movie.overview,
            voteAverage: movie.voteAverage,
            posterPath: movie.posterPath,
            backdropPath: movie.backdropPath);

  String get genresAndLanguage {
    String s = '';

    for (var genre in genres) {
      s += genre + (genre != genres.last ? ', ' : '');
    }

    return '$s - $language';
  }

  @override
  List<Object> get props => [genres, language];
}
