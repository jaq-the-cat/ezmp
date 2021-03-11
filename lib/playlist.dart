import 'package:flutter/material.dart';
import 'dialogs.dart';
import 'queue.dart';
import 'songlistwidget.dart';

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
            ),
            body: ListView(
                children: <Widget>[ // top bit
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Center(
                            child: ElevatedButton.icon(
                                icon: Icon(Icons.music_note),
                                label: Text("Add Song"),
                                onPressed: () => showAddSongDialog(context).then((songs) => setState(() => widget.songs.addAll(songs ?? []))),
                            ),
                        ),
                    ),
                ] + getSongListWidget(widget.songs, context),
            ),
            floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                    ElevatedButton.icon(
                        icon: Icon(Icons.shuffle),
                        label: Text("Shuffle"),
                        onPressed: () => globalQueue.toggleShuffle(),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton.icon(
                        icon: Icon(Icons.play_arrow),
                        label: Text("Play"),
                        onPressed: () => globalQueue.togglePlayPause(),
                    ),
                ],
            ),
        );
    }
}
