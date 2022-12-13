class DataModel {
  final String? artist;
  final String? title;
  final String? album;
  final String? releaseDate;
  final String? label;
  final String? timeCode;
  final String? songLink;
  final Map? appleMusic;
  final Map? spotify;
  final Map? lyrics;

  const DataModel({
    this.artist,
    this.title,
    this.album,
    this.releaseDate,
    this.label,
    this.timeCode,
    this.songLink,
    this.appleMusic,
    this.spotify,
    this.lyrics,
  });

  static DataModel fromJson(Map<String, dynamic> json) => DataModel(
      artist: json['artist'] as String?,
      title: json['title'] as String?,
      album: json['album'] as String?,
      releaseDate: json['release_date'] as String?,
      label: json['label'] as String?,
      timeCode: json['timecode'] as String?,
      songLink: json['song_link'] as String?,
      appleMusic: json['apple_music'] as Map?,
      spotify: json['spotify'] as Map?,
      lyrics: json['lyrics'] as Map?);
}
