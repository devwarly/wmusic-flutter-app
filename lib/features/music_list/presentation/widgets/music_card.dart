import 'package:flutter/material.dart';
import 'package:music_player_app/features/music_player/domain/music_model.dart';


class MusicCard extends StatelessWidget {
  final MusicModel music;
  final VoidCallback? onTap;
  final VoidCallback? onPlayTap;

  const MusicCard({
    super.key,
    required this.music,
    this.onTap,
    this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Row(
          children: [
            // 1. Capa da Música
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                music.imageUrl,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 48,
                  height: 48,
                  color: const Color(0xFF242831),
                  child: const Icon(Icons.music_note, color: Colors.white54, size: 24),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // 2. Título e Artista
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    music.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    music.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF8E95A5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // 3. Botão Play Lateral
            IconButton(
              onPressed: onPlayTap ?? onTap,
              splashRadius: 20,
              icon: const Icon(
                Icons.play_arrow_outlined,
                color: Color(0xFF00A3FF), // Azul em destaque da interface
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}