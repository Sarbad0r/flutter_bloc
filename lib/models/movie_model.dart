class Movie {
  int? id;
  String? title;
  String? originalTitle;
  String? overview;
  bool? video;
  double? voteAverage;
  double? voteCount;
  double? popularity;
  String? backdropPath;
  String? posterPath;
  bool? adult;
  double? qty;

  Movie(
      {this.id,
      this.title,
      this.originalTitle,
      this.overview,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.popularity,
      this.backdropPath,
      this.posterPath,
      this.adult,
      this.qty = 0});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['title'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        video: json['video'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'].toDouble(),
        popularity: json['popularity'],
        backdropPath: json['backdrop_path'],
        posterPath: json['poster_path'],
        adult: json['adult']);
  }

  factory Movie.cloneCart(Movie movie) {
    return Movie(
        id: movie.id,
        title: movie.title,
        originalTitle: movie.originalTitle,
        overview: movie.overview,
        video: movie.video,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
        popularity: movie.popularity,
        backdropPath: movie.backdropPath,
        posterPath: movie.posterPath,
        adult: movie.adult);
  }
}
