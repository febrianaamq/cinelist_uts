import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../data/show_api.dart';

class MovieDetailPage extends StatefulWidget {
  final int showId;

  const MovieDetailPage({
    super.key,
    required this.showId,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
late Future<Show> _showFuture;

@override
void initState() {
super.initState();

_showFuture = fetchShowDetail(widget.showId);
}

String _cleanSummary(String? summary) {
if (summary == null || summary.isEmpty) {
return 'Ringkasan belum tersedia.';
}

return summary
.replaceAll(RegExp(r'<[^>]*>'), ' ')
.replaceAll('&nbsp;', ' ')
.replaceAll('&amp;', '&')
.replaceAll('&quot;', '"')
.replaceAll('&#39;', "'")
.replaceAll('&lt;', '<')
.replaceAll('&gt;', '>')
.replaceAll(RegExp(r'\s+'), ' ')
.trim();
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Detail Serial'),
backgroundColor: const Color(0xFF6750A4),
foregroundColor: Colors.white,
),

body: FutureBuilder<Show>(
future: _showFuture,
builder: (context, snapshot) {
if (snapshot.connectionState == ConnectionState.waiting) {
return const Center(
child: CircularProgressIndicator(),
);
}

if (snapshot.hasError) {
return const Center(
child: Padding(
padding: EdgeInsets.all(24),
child: Text(
'Detail serial gagal dimuat. '
'Periksa koneksi internet dan coba lagi.',
textAlign: TextAlign.center,
),
),
);
}

final show = snapshot.data;

if (show == null) {
return const Center(
child: Text('Data serial tidak ditemukan.'),
);
}

return _buildDetailContent(show);
},
),
);
}

Widget _buildDetailContent(Show show) {
return SingleChildScrollView(
padding: const EdgeInsets.all(16),

child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Center(
child: show.imageUrl != null
? Image.network(
show.imageUrl!,
height: 300,
width: 220,
fit: BoxFit.cover,

errorBuilder: (context, error, stackTrace) {
return const SizedBox(
height: 300,
width: 220,
child: Center(
child: Icon(
Icons.broken_image,
size: 60,
),
),
);
},
)
: const SizedBox(
height: 300,
width: 220,
child: Center(
child: Icon(
Icons.movie_outlined,
size: 60,
),
),
),
),

const SizedBox(height: 24),

Text(
show.name,
style: const TextStyle(
fontSize: 26,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 12),

Row(
children: [
const Icon(
Icons.star,
color: Colors.amber,
size: 24,
),
const SizedBox(width: 6),

Text(
show.rating > 0
? show.rating.toStringAsFixed(1)
: 'Belum ada rating',
style: const TextStyle(fontSize: 16),
),
],
),

const SizedBox(height: 16),

_buildInfoRow(
'Genre',
show.genres.isNotEmpty
? show.genres.join(', ')
: 'Tidak tersedia',
),

_buildInfoRow(
'Tayang perdana',
show.premiered ?? 'Tidak tersedia',
),

_buildInfoRow(
'Status',
show.status ?? 'Tidak tersedia',
),

const SizedBox(height: 20),

const Text(
'Ringkasan Cerita',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 8),

Text(
_cleanSummary(show.summary),
style: const TextStyle(
fontSize: 15,
height: 1.6,
),
),

const SizedBox(height: 24),
],
),
);
}

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Text(': '),

          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}