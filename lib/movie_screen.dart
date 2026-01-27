import 'package:flutter/material.dart';
import 'package:movie_app/movie_model.dart';
import 'package:intl/intl.dart';

class MovieScreen extends StatelessWidget {
  final MovieModel movie;

  const MovieScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.movieName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 8.0,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    movie.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.movie, size: 100),
                      );
                    },
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categories
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: movie.categories.map((category) {
                      return Chip(
                        label: Text(category),
                        backgroundColor: Colors.blue[100],
                        labelStyle: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Release Date
                  _buildDetailRow(
                    icon: Icons.calendar_today,
                    label: 'Released',
                    value: DateFormat('MMMM dd, yyyy').format(movie.releasedDate),
                  ),
                  const SizedBox(height: 16),

                  // Director
                  _buildDetailRow(
                    icon: Icons.person_outline,
                    label: 'Director',
                    value: movie.director,
                  ),
                  const SizedBox(height: 16),

                  // Writer
                  _buildDetailRow(
                    icon: Icons.edit_outlined,
                    label: 'Writer',
                    value: movie.writer,
                  ),
                  const SizedBox(height: 16),

                  // Stars
                  _buildDetailRow(
                    icon: Icons.star_outline,
                    label: 'Stars',
                    value: movie.stars,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: Colors.blue[700]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
