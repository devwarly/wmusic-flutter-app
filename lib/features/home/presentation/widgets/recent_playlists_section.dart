import 'package:flutter/material.dart';
import 'package:music_player_app/features/playlists/domain/models/playlist_model.dart';
import 'recent_playlist_card.dart';

class RecentPlaylistsSection extends StatelessWidget {
  final List<PlaylistModel> playlists;
  final Function(PlaylistModel)? onPlaylistTap;

  const RecentPlaylistsSection({
    super.key,
    required this.playlists,
    this.onPlaylistTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Playlists Recentes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: playlists.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 56, // Altura fixa de cada card
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final playlist = playlists[index];
            return RecentPlaylistCard(
              playlist: playlist,
              onTap: () => onPlaylistTap?.call(playlist),
            );
          },
        ),
      ],
    );
  }
}