import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class FavoritesView extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => FavoritesViewState();

  const FavoritesView({super.key});
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLastPage || isLoading) return;
    isLoading = true;
    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, Movie>? movies = ref.watch(favoriteMoviesProvider);
    if (movies == null) {
      return const CircularProgressIndicator(
        strokeWidth: 2,
      );
    }
    // Convertir de mapa a lista de movie
    final List<Movie> moviesList = movies.values.toList();

    return Scaffold(
        body: MovieMasonry(loadNextPage: loadNextPage, movies: moviesList));
  }
}
