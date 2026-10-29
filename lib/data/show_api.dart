import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

Future<List<Show>> fetchShows() async {
  final url = Uri.parse('http://api.tvmaze.com/shows');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.take(50).map((item) => Show.fromJson(item as Map<String, dynamic>)).toList();
  } else {
    throw Exception('gagal mengambil data serial');
  }
}

Future<Show> fetchShowDetail(int id) async {
  final url = Uri.parse('http://api.tvmaze.com/shows/$id');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
    return Show.fromJson(data);
  } else {
    throw Exception('gagal mengambil detail serial');
  }
}