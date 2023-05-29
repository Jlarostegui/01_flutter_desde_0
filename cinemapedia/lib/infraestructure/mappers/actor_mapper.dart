import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/infraestructure/models/models.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? '${UrlMovies.path.value}${cast.profilePath}'
          : 'https://thumbs.dreamstime.com/b/no-user-profile-picture-hand-drawn-illustration-53840792.jpg',
      character: cast.character ?? '');
}
