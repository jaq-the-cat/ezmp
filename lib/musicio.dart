extension RenameKey on Map {
    void renameKey(String oldKey, String newKey) {
        var value = this[oldKey];
        this.remove(oldKey);
        this[newKey] = value;
    }
}

Map<String, Set<String>> getPlaylists() {
    return {
        "Playlist 1": ["/path/to/song/1", "/path/to/song/2"].toSet(),
        "Playlist 2": ["/path/to/song/1", "/path/to/song/2", "/path/to/song/3"].toSet(),
        "Playlist 3": ["/path/to/song/1"].toSet(),
        "Playlist 4": Set(),
    };
}

void savePlaylists(Map<String, Set<String>> playlists) {
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
