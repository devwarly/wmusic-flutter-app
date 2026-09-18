import 'package:flutter/material.dart';
import 'package:music_player_app/features/music_list/presentation/widgets/music_card.dart';
import 'package:music_player_app/features/music_player/domain/music_model.dart';


class MusicsSection extends StatelessWidget {
  final List<MusicModel> musics;
  final Function(MusicModel)? onMusicTap;
  final VoidCallback? onShuffleTap;
  final VoidCallback? onSortTap;

  const MusicsSection({
    super.key,
    required this.musics,
    this.onMusicTap,
    this.onShuffleTap,
    this.onSortTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Músicas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        // Botões de Ação (Aleatório e Ordem)
        Row(
          children: [
            // Botão Aleatório
            ElevatedButton.icon(
              onPressed: onShuffleTap,
              icon: const Icon(Icons.shuffle, size: 16, color: Colors.white),
              label: const Text('Aleatório', style: TextStyle(color: Colors.white, fontSize: 12)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A3FF),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const SizedBox(width: 10),

            // Botão Ordem
            OutlinedButton.icon(
              onPressed: onSortTap,
              icon: const Icon(Icons.subject, size: 16, color: Colors.white70),
              label: const Text('Ordem', style: TextStyle(color: Colors.white70, fontSize: 12)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white.withOpacity(0.15)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Lista de Músicas
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: musics.length,
          itemBuilder: (context, index) {
            final music = musics[index];
            return MusicCard(
              music: music,
              onTap: () => onMusicTap?.call(music),
            );
          },
        ),
      ],
    );
  }
}