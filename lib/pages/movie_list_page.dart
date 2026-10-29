import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';

class MovieListPage extends StatelessWidget {
  final List<Show> shows;
  final ValueChanged<Show> onShowTap;
  const MovieListPage({
    super.key,
    required this.shows,
    required this.onShowTap,
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar serial'),
        backgroundColor: const Color(0xFF6750A4),
        foregroundColor: Colors.white,
      ),

      body: Padding(
          padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: shows.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.55,
            ),
            itemBuilder: (context, index) {
              final show = shows[index];

            return MovieCard(
                show: show,
                onTap: () {
                  onShowTap(show);
                },
            );
            },
        ),
      ),
    );
  }
}