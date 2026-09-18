import 'package:flutter/material.dart';
import 'package:music_player_app/features/music_player/domain/music_model.dart';


class BottomPlayerNavigationBar extends StatelessWidget {
  final MusicModel? currentMusic;
  final bool isPlaying;
  final double progress; // Valor entre 0.0 e 1.0
  final int currentTabIndex;
  final ValueChanged<int>? onTabSelected;
  final VoidCallback? onPlayPause;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final String? userAvatarUrl;

  const BottomPlayerNavigationBar({
    super.key,
    this.currentMusic,
    this.isPlaying = false,
    this.progress = 0.35, // Exemplo de progresso inicial
    this.currentTabIndex = 0,
    this.onTabSelected,
    this.onPlayPause,
    this.onNext,
    this.onPrevious,
    this.userAvatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1B1E26), // Fundo do painel inferior
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. ÁREA DO MINI PLAYER
          if (currentMusic != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
              child: Row(
                children: [
                  // Capa da música
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Image.network(
                      currentMusic!.imageUrl,
                      width: 44,
                      height: 44,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 44,
                        height: 44,
                        color: const Color(0xFF2B303C),
                        child: const Icon(Icons.music_note, color: Colors.white54, size: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Título da Música e Cantor
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currentMusic!.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          currentMusic!.artist,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF8E95A5),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Controles do Player (Voltar, Play/Pause, Avançar)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: onPrevious,
                        icon: const Icon(Icons.skip_previous_rounded),
                        color: Colors.white,
                        iconSize: 26,
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(6),
                      ),
                      IconButton(
                        onPressed: onPlayPause,
                        icon: Icon(isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
                        color: Colors.white,
                        iconSize: 28,
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(6),
                      ),
                      IconButton(
                        onPressed: onNext,
                        icon: const Icon(Icons.skip_next_rounded),
                        color: Colors.white,
                        iconSize: 26,
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(6),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 2. BARRA DE PROGRESSO
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 2.0,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 4.0),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 8.0),
                activeTrackColor: const Color(0xFF00A3FF),
                inactiveTrackColor: Colors.white.withOpacity(0.2),
                thumbColor: const Color(0xFF00A3FF),
              ),
              child: Slider(
                value: progress.clamp(0.0, 1.0),
                onChanged: (value) {},
              ),
            ),
          ],

          // 3. BARRA DE NAVEGAÇÃO INFERIOR
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.music_note_rounded,
                  label: 'Songs',
                  isSelected: currentTabIndex == 0,
                  onTap: () => onTabSelected?.call(0),
                ),
                _NavItem(
                  icon: Icons.queue_music_rounded,
                  label: 'Playlist',
                  isSelected: currentTabIndex == 1,
                  onTap: () => onTabSelected?.call(1),
                ),
                _NavItem(
                  icon: Icons.file_download_outlined,
                  label: 'Import',
                  isSelected: currentTabIndex == 2,
                  onTap: () => onTabSelected?.call(2),
                ),
                _NavItem(
                  label: 'Perfil',
                  isSelected: currentTabIndex == 3,
                  onTap: () => onTabSelected?.call(3),
                  customWidget: CircleAvatar(
                    radius: 11,
                    backgroundColor: currentTabIndex == 3 ? const Color(0xFF00A3FF) : Colors.transparent,
                    
                    child: CircleAvatar(
                      radius: 10,
                      backgroundImage: userAvatarUrl != null ? NetworkImage(userAvatarUrl!) : null,
                      child: userAvatarUrl == null
                          ? const Icon(Icons.person, size: 12, color: Colors.white)
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar para os botões da barra inferior
class _NavItem extends StatelessWidget {
  final IconData? icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? customWidget;

  const _NavItem({
    this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.customWidget,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = const Color(0xFF00A3FF);
    final inactiveColor = const Color(0xFF8E95A5);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (customWidget != null)
              customWidget!
            else
              Icon(
                icon,
                color: isSelected ? activeColor : inactiveColor,
                size: 20,
              ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? activeColor : inactiveColor,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}