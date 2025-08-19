import 'package:flutter/material.dart';

class ScreenshotCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const ScreenshotCard({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // control width while height is taken from parent SizedBox
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,   // fills container height
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
