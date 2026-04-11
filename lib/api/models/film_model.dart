class FilmModel {
  final List<String> characters;
  final DateTime createdAt;
  final String director;
  final int episodeId;
  final String openingCrawl;
  final List<String> planets;
  final String producer;
  final String releaseDate;

  final List<String> species;
  final List<String> starships;
  final String title;

  const FilmModel({
    required this.species,
    required this.starships, required this.title, required this.characters,
    required this.createdAt,
    required this.director,
    required this.episodeId,
    required this.openingCrawl,
    required this.planets,
    required this.producer,
    required this.releaseDate,
  });

  factory FilmModel.fromJson(Map<String, dynamic> json) {
    return FilmModel(
      species: json['species'].cast<String>(),
      starships: json['starships'].cast<String>(),
      title: json['title'],
      characters: json['characters'].cast<String>(),
      createdAt: DateTime.parse(json['created']),
      director: json['director'],
      episodeId: json['episode_id'],
      openingCrawl: json['opening_crawl'],
      planets: json['planets'].cast<String>(),
      producer: json['producer'],
      releaseDate: json['release_date'],
    );
  }

  @override
  String toString() {
    return 'FilmModel(title: $title)';
  }
}
