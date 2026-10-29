import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../data/show_api.dart';
import 'movie_list_page.dart';
import 'movie_detail_page.dart';
import '../widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Show>> _showsFuture;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _showsFuture = fetchShows();
  }

  void _openDetail(Show show) {
    Navigator.push(
        context,
      MaterialPageRoute(builder: (context) {
        return MovieDetailPage(showId: show.id);
      },
      ),
    );
  }

  void _retryFetch() {
    setState(() {
      _showsFuture = fetchShows();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SeriesList'),
        backgroundColor: const Color(0xFF6750A4),
        foregroundColor: Colors.white,
      ),

      body: FutureBuilder<List<Show>>(
        future: _showsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.wifi_off,
                      size: 48,
                    ),
                    const SizedBox(height: 12),

                    const Text(
                      'Data gagal dimuat. Periksa koneksi internet.',
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    ElevatedButton(
                      onPressed: _retryFetch,
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final shows = snapshot.data ?? <Show>[];

          if (shows.isEmpty) {
            return const Center(
              child: Text('Belum ada data serial.'),
            );
          }

          if (_selectedIndex == 1) {
            return MovieListPage(
              shows: shows,
              onShowTap: _openDetail,
            );
          }

          return _buildHomeContent(shows);
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,

        selectedItemColor: const Color(0xFF6750A4),

        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Daftar',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent(List<Show> shows) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'temukan serial favoritmu',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'jelajahi berbagai serial dari seluruh dunia',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 24),

        const Text(
          'serial unggulan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,

            itemCount: shows.length > 10 ? 10 : shows.length,
            itemBuilder: (context, index) {
              final show = shows[index];

              return SizedBox(
                width: 180,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),

                  child: MovieCard(
                      show: show,
                      onTap: () {
                        _openDetail(show);
                      },
                      ),
                ),
              );
            },
          ),
        ),

    const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
            icon: const Icon(Icons.grid_view),
            label: const Text('lihat semua serial'),
                ),
        ),
      ],
    );
  }
}