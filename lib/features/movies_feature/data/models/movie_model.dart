class MovieModel {
  final String imageUrl;
  final String movieName;
  final String director;
  final String writer;
  final String stars;
  final List<String> categories;
  final DateTime releasedDate;

  MovieModel(
    this.imageUrl,
    this.movieName,
    this.director,
    this.writer,
    this.stars,
    this.releasedDate,
    this.categories,
  );
}
