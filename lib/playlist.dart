import 'package:flutter/material.dart';
import 'dialogs.dart';
import 'queue.dart';

@immutable
class _AfterMenu {
    _AfterMenu({this.playNext, this.remove});

    final bool playNext;
    final bool remove;
}

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
                children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                ElevatedButton.icon(
                                    icon: Icon(Icons.shuffle),
                                    label: Text("Shuffle"),
                                    onPressed: () => globalQueue.toggleShuffle(),
                                ),
                                SizedBox(width: 5),
                                ElevatedButton.icon(
                                    icon: Icon(Icons.play_arrow),
                                    label: Text("Play"),
                                    onPressed: () => globalQueue.togglePlayPause(),
                                ),
                            ]
                        )
                    ),
                ] + widget.songs.map(
                    (songName) => Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Text(
                                            songName,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                            )
                                        ),
                                        Text(
                                            "XX:XX",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white38,
                                            )
                                        ),
                                    ],
                                ),
                                IconButton(
                                    icon: Icon(Icons.menu),
                                    iconSize: 18,
                                    onPressed: () => showEditDialog(
                                        context,
                                        () => Navigator.of(context).pop(_AfterMenu(playNext: true)),
                                        () => Navigator.of(context).pop(_AfterMenu(remove: true)),
                                    ).then((r) {
                                        if (r.playNext == true)
                                            globalQueue.playNext(songName);
                                        else if (r.remove == true)
                                            globalQueue.remove(songName);
                                    }),
                                )
                            ]
                        ),
                    ),
                ).toList(),
            ),
            floatingActionButton:  ElevatedButton.icon(
                icon: Icon(Icons.music_note),
                label: Text("Add Song"),
                onPressed: () => showAddSongDialog(context).then((songs) => setState(() => widget.songs.addAll(songs))),
            ),
        );
    }
}
