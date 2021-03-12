import 'package:flutter/material.dart';
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
            body: ListView(
                children: getSongListWidget(context, name: widget.name,
                    onRemove: (String songName) => setState(() => Playlists.removeSong(widget.name, songName))),
            ),
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
                    onPressed: () {
                        globalQueue.shuffle = true;
                        globalQueue.play(Playlists.songs(widget.name));
                    }
                ),
                TextButton.icon(
                    icon: Icon(Icons.play_arrow),
                    label: Text("Play"),
                    onPressed: () => globalQueue.play(Playlists.songs(widget.name)),
                ),
            ],
        );
    }
}
