import 'package:flutter/material.dart';
import '../../../../core/constants/app_breakpoints.dart';

class ResponsiveHomeScreen extends StatelessWidget {
  const ResponsiveHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppBreakpoints.desktop) {
          return const DesktopLayout();
        }
        return const MobileLayout();
      },
    );
  }
}

// Estrutura de 3 Colunas para Desktop/Web
class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          // 1. Sidebar de Navegação Esquerda
          SizedBox(
            width: 240,
            child: DesktopSidebar(),
          ),
          // 2. Conteúdo Principal Central (Busca, Playlists, Lista de Músicas)
          Expanded(
            flex: 3,
            child: MainContentArea(),
          ),
          // 3. Painel do Player Direito (Capa, Título, Play/Pause, Timeline)
          SizedBox(
            width: 380,
            child: DesktopPlayerPanel(),
          ),
        ],
      ),
    );
  }
}

// Estrutura para Mobile
class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MainContentArea(),
          // Player fixo na parte inferior acima da BottomNav
          Positioned(
            left: 8,
            right: 8,
            bottom: 60,
            child: MiniPlayerBar(),
          ),
        ],
      ),
      bottomNavigationBar: const MobileBottomNav(),
    );
  }
}