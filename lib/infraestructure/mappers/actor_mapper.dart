import '../../domain/entities/actor.dart';
import '../models/credits_response.dart';

class ActorMapper{
  static Actor castToEntity(Cast cast)=>Actor(
  caracter: cast.character,
  name: cast.name,
  profilePath:cast.profilePath!=null
  ?'https://image.tmdb.org/t/p/w500${cast.profilePath}'
  :'https://resourcesdev.blob.core.windows.net/resources-web/proyectos/poster-not-found.png',
  id:cast.id
  );
}