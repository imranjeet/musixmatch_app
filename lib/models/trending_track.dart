// ignore_for_file: non_constant_identifier_names

class DataModel {
  String? track_name;
  int? track_id;
  String? album_name;
  String? artist_name;
  int? explicit;
  int? track_rating;

  DataModel({
    this.track_name,
    this.track_id,
    this.album_name,
    this.artist_name,
    this.explicit,
    this.track_rating,
  });

  factory DataModel.fromJson(Map<String, dynamic> result) {
    return DataModel(
      track_name: result['track_name'],
      album_name: result['album_name'],
      artist_name: result['artist_name'],
      track_id: result['track_id'],
      explicit: result['explicit'],
      track_rating: result['track_rating'],
    );
  }
}
