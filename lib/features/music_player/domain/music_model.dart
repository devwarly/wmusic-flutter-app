class MusicModel {
  final String id;
  final String title;
  final String artist;
  final Duration duration;
  final String imageUrl;
  final String audioUrl; // Necessário para execução no player de áudio

  const MusicModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
    required this.imageUrl,
    this.audioUrl = '',
  });

  // Getter formatador de duração (retorna "MM:SS" ou "HH:MM:SS")
  String get formattedDuration {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours > 0) {
      final hours = twoDigits(duration.inHours);
      return "$hours:$minutes:$seconds";
    }
    
    return "$minutes:$seconds";
  }
}