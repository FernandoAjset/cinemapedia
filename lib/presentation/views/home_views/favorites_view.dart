import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

    if (moviesList.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline_sharp,
              size: 60,
              color: colors.primary,
            ),
            Text(
              'Upss!!',
              style: TextStyle(fontSize: 30, color: colors.primary),
            ),
            const Text(
              'Aun no tienes películas favoritas.',
              style: TextStyle(fontSize: 20, color: Colors.black45),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton.tonal(
                onPressed: () => context.go('/'),
                child: const Text('Empieza a buscar'))
          ],
        ),
      );
    }

    return Scaffold(
        body: MovieMasonry(loadNextPage: loadNextPage, movies: moviesList));
  }
}
