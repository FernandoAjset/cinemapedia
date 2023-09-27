import '../../domain/entities/actor.dart';
import '../models/credits_response.dart';

class ActorMapper{
  static Actor castToEntity(Cast cast)=>Actor(
  caracter: cast.character,
  name: cast.name,
  profilePath:cast.profilePath!=null
  ?'https://image.tmdb.org/t/p/w500${cast.profilePath}'
  :'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
  id:cast.id
  );
}