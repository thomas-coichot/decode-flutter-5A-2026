import '../../services/api_service.dart';
import '../models/film_model.dart';
import 'model_repository.dart';

class FilmRepository extends ModelRepository {
  const FilmRepository()
    : super(
        uri: 'films',
        fromJson: FilmModel.fromJson,
      );

  Future getStarships(String id) {
    return ApiService().request(
      uri: '$uri/$id/starships',
    );
  }
}
