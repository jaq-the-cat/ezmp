import 'package:flutter_audio_query/flutter_audio_query.dart';

final FlutterAudioQuery _audioQuery = FlutterAudioQuery();

class Playlists {
    static Set<String> get names {
        return {
            "Playlist 1",
            "Playlist 2",
            "Playlist 3",
            "Playlist 4",
        };
    }

    static Set<SongInfo> songs(String name) {
        return {};
    }

    static Future<List<SongInfo>> getSongs() async {
        _audioQuery.getSongs();
    }

    static void addSongs(String name, Set<String> songs) {
    }

    static void removeSong(String name, String songName) {
    }

    static void rename(String oldName, String newName) {
    }

    static void add(String name) {
    }

    static void remove(String name) {
    }
}
