class Playlists {

    static Set<String> get names {
        return {
            "Playlist 1",
            "Playlist 2",
            "Playlist 3",
            "Playlist 4",
        };
    }

    static Set<String> songs(String name) {
        return {
            "Playlist 1": ["/path/to/song/1", "/path/to/song/2"].toSet(),
            "Playlist 2": ["/path/to/song/1", "/path/to/song/2", "/path/to/song/3"].toSet(),
            "Playlist 3": ["/path/to/song/1"].toSet(),
            "Playlist 4": <String>{},
        }[name];
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

Set<String> getSongs() {
    return [
        "/path/to/song/1",
        "/path/to/song/2",
        "/path/to/song/3",
        "/path/to/song/4",
        "/path/to/song/5",
        "/path/to/song/6",
        "/path/to/song/7",
        "/path/to/song/8",
        "/path/to/song/9",
        "/path/to/song/10",
        "/path/to/song/11",
        "/path/to/song/12",
        "/path/to/song/13",
        "/path/to/song/14",
        "/path/to/song/15",
        "/path/to/song/16",
        "/path/to/song/17",
        "/path/to/song/18",
        "/path/to/song/19",
        "/path/to/song/20",
        "/path/to/song/21",
        "/path/to/song/22",
        "/path/to/song/23",
        "/path/to/song/24",
        "/path/to/song/25",
        "/path/to/song/26",
        "/path/to/song/27",
        "/path/to/song/28",
        "/path/to/song/29",
        "/path/to/song/30",
    ].toSet();
}
