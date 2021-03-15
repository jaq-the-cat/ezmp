import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

final FlutterAudioQuery _audioQuery = FlutterAudioQuery();

class Playlists {
    static Future<Set<String>> get names async {
        final prefs = await SharedPreferences.getInstance();
        return prefs.getKeys().where((key) {
            try {
                prefs.getStringList(key);
                return true;
            } catch(exc) {
                return false;
            }
        });
    }

    static Future<List<SongInfo>> songs(String name) async {
        final prefs = await SharedPreferences.getInstance();
        List<String> songIds = prefs.getStringList(name);
        return _audioQuery.getSongsById(ids: songIds);
    }

    static Future<List<SongInfo>> getSongs() async {
        return _audioQuery.getSongs();
    }

    static Future<void> addSongs(String name, Set<String> songIds) async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setStringList(name, songIds.toList());
    }

    static Future<void> removeSong(String name, String songId) async {
        final prefs = await SharedPreferences.getInstance();
        List<String> songs;
        try {
            songs = prefs.getStringList(name);
        } catch(exc) {
            songs = [];
        }
        songs.remove(songId);
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
