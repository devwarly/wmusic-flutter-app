import 'package:flutter/material.dart';
import 'package:music_player_app/main.dart';
import '../../../playlists/domain/models/playlist_model.dart';
import '../widgets/recent_playlists_section.dart';


class MobileHomeContent extends StatelessWidget {
  const MobileHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchHeader(),
            const SizedBox(height: 24),
            RecentPlaylistsSection(
              playlists: mockPlaylists,
              onPlaylistTap: (playlist) {
                // Lógica de navegação ou reprodução
              },
            ),
          ],
        ),
      ),
    );
  }
}