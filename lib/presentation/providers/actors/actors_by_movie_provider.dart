
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/actor.dart';
import '../providers.dart';


final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final getActorsCallback = ref.watch(actorsRepositoryProvider).getActorsByMovie;
  return ActorsByMovieNotifier(getActorsCallback: getActorsCallback);
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActorsCallback;

  ActorsByMovieNotifier({required this.getActorsCallback}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;
    final List<Actor> actors = await getActorsCallback(movieId);
    state = {...state, movieId: actors};
  }
}
