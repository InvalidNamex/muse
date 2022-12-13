class LyricsModel {
  final String? songId;
  final String? artistId;
  final String? title;
  final String? titleWithFeatured;
  final String? fullTitle;
  final String? artist;
  final String? lyrics;
  const LyricsModel({
    this.songId,
    this.artistId,
    this.title,
    this.titleWithFeatured,
    this.fullTitle,
    this.artist,
    this.lyrics,
  });

  static LyricsModel fromJson(Map<String, dynamic> json) => LyricsModel(
        songId: json['song_id'] as String?,
        artistId: json['artist_id'] as String?,
        title: json['title'] as String?,
        titleWithFeatured: json['title_with_featured'] as String?,
        fullTitle: json['full_title'] as String?,
        artist: json['artist'] as String?,
        lyrics: json['lyrics'] as String?,
      );
}
