import 'package:flutter/material.dart';
import 'package:music_player_app/features/home/presentation/widgets/bottom_player_navigation_bar.dart';
import 'package:music_player_app/features/music_player/domain/music_model.dart';
import 'package:music_player_app/features/playlists/domain/models/playlist_model.dart';
import 'package:music_player_app/features/home/presentation/widgets/recent_playlists_section.dart';
import 'package:music_player_app/musics_section.dart';
import 'package:music_player_app/search-header.dart';

// Mocks de dados
final mockPlaylists = [
  const PlaylistModel(
    id: '1',
    title: 'Tudo em um',
    songCount: 28,
    imageUrl: 'https://akamai.sscdn.co/uploadfile/letras/fotos/4/9/a/7/49a76871d4af26393bac3f97402b766b.jpg',
  ),
  const PlaylistModel(
    id: '2',
    title: 'Modão sertanejo - As melhores',
    songCount: 105,
    imageUrl: 'https://picsum.photos/201',
  ),
  const PlaylistModel(
    id: '3',
    title: 'Henrique & Juliano - Manifesto musical',
    songCount: 67,
    imageUrl: 'https://cdn.jornaldebrasilia.com.br/wp-content/uploads/2023/04/20155950/HJ-capa-TO-BE-EP-3-1-scaled.jpg',
  ),
  const PlaylistModel(
    id: '4',
    title: 'Forró Raiz',
    songCount: 124,
    imageUrl: 'https://picsum.photos/203',
  ),
];

final mockMusics = [
  const MusicModel(
    id: '1',
    title: 'Título da Música 1',
    artist: 'Nome do Artista',
    duration: Duration(minutes: 3, seconds: 20),
    imageUrl: 'https://picsum.photos/200',
  ),
  const MusicModel(
    id: '2',
    title: 'Título da Música 2',
    artist: 'Nome do Artista',
    duration: Duration(minutes: 2, seconds: 45),
    imageUrl: 'https://picsum.photos/201',
  ),

  const MusicModel(
    id: '3',
    title: 'Bem',
    artist: 'Chapéu de Palha',
    duration: Duration(minutes: 4, seconds: 30),
    imageUrl: 'https://akamai.sscdn.co/uploadfile/letras/fotos/4/9/a/7/49a76871d4af26393bac3f97402b766b.jpg',
  ),

  const MusicModel(
    id: '4',
    title: 'Título da Música 2',
    artist: 'Nome do Artista',
    duration: Duration(minutes: 2, seconds: 45),
    imageUrl: 'https://picsum.photos/204',
  ),

  const MusicModel(
    id: '5',
    title: 'Título da Música 2',
    artist: 'Nome do Artista',
    duration: Duration(minutes: 2, seconds: 45),
    imageUrl: 'https://picsum.photos/205',
  ),

  const MusicModel(
    id: '6',
    title: 'Título da Música 2',
    artist: 'Nome do Artista',
    duration: Duration(minutes: 2, seconds: 45),
    imageUrl: 'https://picsum.photos/201',
  ),
];

void main() {
  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF101216),
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;
  bool _isPlaying = true;
  MusicModel? _currentPlaying;

  @override
  void initState() {
    super.initState();
    // Define a primeira música do mock como a música atual ao iniciar
    if (mockMusics.isNotEmpty) {
      _currentPlaying = mockMusics.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  // Ação ao clicar na playlist
                },
              ),
              const SizedBox(height: 24),
              MusicsSection(
                musics: mockMusics,
                onMusicTap: (music) {
                  setState(() {
                    _currentPlaying = music;
                    _isPlaying = true;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomPlayerNavigationBar(
        currentMusic: _currentPlaying,
        isPlaying: _isPlaying,
        progress: 0.4,
        currentTabIndex: _selectedTab,
        userAvatarUrl: 'https://picsum.photos/100',
        onTabSelected: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        onPlayPause: () {
          setState(() {
            _isPlaying = !_isPlaying;
          });
        },
        onNext: () {
          // Lógica de próxima música
        },
        onPrevious: () {
          // Lógica de música anterior
        },
      ),
    );
  }
}