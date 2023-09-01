import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/shared/custom_buttom_navigationbar.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomButtomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowNowPlayingMovies = ref.watch(moviesSlideShowPriver);
    if (slideShowNowPlayingMovies.isEmpty)
      return const CircularProgressIndicator();

    return Column(
      children: [
        const CustomAppBar(),
        MoviesSliceShow(movies: slideShowNowPlayingMovies),
        MovieHorizontalListView(
          movies: nowPlayingMovies,
          title: 'En cines',
          subTitle: 'Lunes 20',
        )
      ],
    );
  }
}
