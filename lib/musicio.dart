import 'package:shared_preferences/shared_preferences.dart';
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

    static Future<Set<String>> songs(String name) async {
        final prefs = await SharedPreferences.getInstance();
        return prefs.getStringList(name).toSet();
    }

    static Future<List<SongInfo>> getSongs() async {
        return _audioQuery.getSongs();
    }

    static Future<void> addSongs(String name, Set<String> songs) async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setStringList(name, songs.toList());
    }

    static Future<void> removeSong(String name, String songName) async {
        final prefs = await SharedPreferences.getInstance();
        List<String> songs;
        try {
            songs = prefs.getStringList(name);
        } catch(exc) {
            songs = [];
        }
        songs.remove(songName);
        prefs.setStringList(name, songs);
    }

    static Future<void> rename(String oldName, String newName) async {
        final prefs = await SharedPreferences.getInstance();
        List<String> songs;
        try {
            songs = prefs.getStringList(oldName);
        } catch(exc) {
            songs = null;
        }
        prefs.remove(oldName);
        prefs.setStringList(newName, songs ?? []);
    }

    static Future<void> add(String name) async {
        final prefs = await SharedPreferences.getInstance();
        return prefs.setStringList(name, []);
    }

    static Future<void> remove(String name) async {
        final prefs = await SharedPreferences.getInstance();
        return prefs.remove(name);
    }
}
