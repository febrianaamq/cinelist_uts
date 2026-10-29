import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
 final Show show;
 final VoidCallback onTap;

 const MovieCard({
   super.key,
   required this.show,
   required this.onTap,
});

 @override
  Widget build(BuildContext context) {
   return Card(
     clipBehavior: Clip.antiAlias, elevation: 3,
     child: InkWell(
       onTap: onTap,
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Expanded(
             child: SizedBox(
               width: double.infinity,

               child: show.imageUrl != null ? Image.network(show.imageUrl!, fit: BoxFit.cover,
               errorBuilder: (context, error, stackTrace) {
                 return const Center(
                   child: Icon(
                     Icons.broken_image,
                     size: 48,
                   ),
                 );
               },
               )
                  : const Center(
                 child: Icon(
                   Icons.movie_outlined,
                   size: 48,
                 ),
               ) ,
             ),
         ),
         Padding(
           padding: const EdgeInsets.all(10),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 show.name,
                 maxLines: 2,
                 overflow: TextOverflow.ellipsis,
                 style: const TextStyle(fontWeight: FontWeight.bold,
                 fontSize: 15
                 ),
               ),
               const SizedBox(height: 5),
               Text(show.genres.isNotEmpty ? show.genres.join(',')
               : 'genre tidak tersedia',
                 maxLines: 1,
                 overflow: TextOverflow.ellipsis,
                 style: const TextStyle(fontSize: 12,
                 color: Colors.grey,
                 ),
               ),
               const SizedBox(height: 5),
               Row(
                 children: [
                   Expanded(
                       child: Text(
                         show.premiered != null && show.premiered!.isNotEmpty ? show.premiered!.substring(0, 4)
                             : 'tahun tidak tersedia',
                         style: const TextStyle(fontSize: 11),
                       ),
                   ),
                   const Icon(
                     Icons.star,
                     color: Colors.amber,
                     size: 16,
                   ),
                   Text(
                     show.rating > 0 ? show.rating.toStringAsFixed(1)
                         :'-',
                     style: const TextStyle(fontSize: 12),
                   ),
                 ],
               ),
             ],
           ),
         ),
       ],
     ),
     ),
   );
 }
}