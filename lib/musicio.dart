Map<String, List<String>> getPlaylists() {
    return {
        "Playlist 1": ["/path/to/song/1", "/path/to/song/2"],
        "Playlist 2": ["/path/to/song/1", "/path/to/song/2", "/path/to/song/3"],
        "Playlist 3": ["/path/to/song/1"],
        "Playlist 4": [],
    };
}

void savePlaylists(Map<String, List<String>> playlists) {
}

List<String> getSongs() {
    return [
        "/path/to/song/1",
        "/path/to/song/2",
        "/path/to/song/3",
        "/path/to/song/4",
        "/path/to/song/5",
    ];
}
