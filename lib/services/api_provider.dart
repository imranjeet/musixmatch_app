import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/trending_track.dart';

class DataServices {
  String baseUrl = "https://api.musixmatch.com/ws/1.1/";

  Future<List<DataModel>> fetchMusicList() async {
    http.Response response = await http.get(Uri.parse(
        "${baseUrl}chart.tracks.get?apikey=235264003dd9dd10f4d9110ff85baf79"));
    try {
      if (response.statusCode == 200) {
        var list = json.decode(response.body);
        List<dynamic> newList = list['message']['body']['track_list'];
        var data = newList.map((e) => DataModel.fromJson(e['track'])).toList();
        return data;
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      throw Exception('Failed to load post');
    }
  }

  Future<String> fetchLyrics(int trackId) async {
    http.Response response = await http.get(Uri.parse(
        "${baseUrl}track.lyrics.get?track_id=$trackId&apikey=235264003dd9dd10f4d9110ff85baf79"));
    try {
      if (response.statusCode == 200) {
        var lyrics = json.decode(response.body)['message']['body']['lyrics']
            ['lyrics_body'];
        return lyrics.toString();
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      throw Exception('Failed to load post');
    }
  }
}
