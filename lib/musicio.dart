Map<String, Set<String>> getPlaylists() {
    return {
        "Playlist 1": ["/path/to/song/1", "/path/to/song/2"].toSet(),
        "Playlist 2": ["/path/to/song/1", "/path/to/song/2", "/path/to/song/3"].toSet(),
        "Playlist 3": ["/path/to/song/1"].toSet(),
        "Playlist 4": [].toSet(),
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
    ].toSet();
}
