import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'musicio.dart';
import 'dialogs.dart';
import 'queue.dart';
import 'songlistwidget.dart';
import 'queuepage.dart';

class PlaylistPage extends StatefulWidget {

    PlaylistPage(this.name, {Key key}) : super(key: key);

    final String name;

    @override
    PlaylistState createState() => PlaylistState();
}

class PlaylistState extends State<PlaylistPage> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.name),
                actions: [
                    openQueuePageButton(context),
                ],
            ),
            body: getSongListWidget(context, name: widget.name,
                onRemove: (SongInfo song) => setState(() => Playlists.removeSong(widget.name, song.id))),
            persistentFooterButtons: [
                TextButton.icon(
                    icon: Icon(Icons.music_note),
                    label: Text("Add Song"),
                    onPressed: () => showAddSongDialog(context).then((songs) => setState(() {
                        Playlists.addSongs(widget.name, songs);
                    })),
                ),
                TextButton.icon(
                    icon: Icon(Icons.shuffle),
                    label: Text("Shuffle"),
                    onPressed: () async {
                        globalQueue.shuffle = true;
                        globalQueue.play(await Playlists.songs(widget.name));
                    }
                ),
                TextButton.icon(
                    icon: Icon(Icons.play_arrow),
                    label: Text("Play"),
                    onPressed: () async {
                        globalQueue.play(await Playlists.songs(widget.name));
                    },
                ),
            ],
        );
    }
}
