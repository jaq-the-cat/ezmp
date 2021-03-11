import 'package:flutter/material.dart';
import 'dialogs.dart';
import 'queue.dart';
import 'songlistwidget.dart';
import 'queuepage.dart';

class PlaylistPage extends StatefulWidget {

    PlaylistPage(this.name, this.songs, {Key key}) : super(key: key);

    final String name;
    final Set<String> songs;

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
                children: getSongListWidget(context, widget.songs,
                    onRemove: (String songName) => setState(() => widget.songs.remove(songName))),
            ),
            persistentFooterButtons: [
                TextButton.icon(
                    icon: Icon(Icons.music_note),
                    label: Text("Add Song"),
                    onPressed: () => showAddSongDialog(context).then((songs) => setState(() => widget.songs.addAll(songs ?? []))),
                ),
                TextButton.icon(
                    icon: Icon(Icons.shuffle),
                    label: Text("Shuffle"),
                    onPressed: () {
                        globalQueue.shuffle = true;
                        globalQueue.play(widget.songs);
                    }
                ),
                TextButton.icon(
                    icon: Icon(Icons.play_arrow),
                    label: Text("Play"),
                    onPressed: () => globalQueue.play(widget.songs),
                ),
            ],
        );
    }
}
