import 'package:flutter/material.dart';

@immutable
class _AfterMenu {
    _AfterMenu({this.playNext, this.remove});

    final bool playNext;
    final bool remove;
}

class PlaylistPage extends StatefulWidget {

    PlaylistPage(this.name, this.songs, {Key key}) : super(key: key);

    final String name;
    final List<String> songs;

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
                                    onPressed: () {},
                                ),
                                SizedBox(width: 5),
                                ElevatedButton.icon(
                                    icon: Icon(Icons.play_arrow),
                                    label: Text("Play"),
                                    onPressed: () {},
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
                                    onPressed: () => showEditDialog(context).then((r) {
                                        print(r.playNext);
                                        print(r.remove);
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
                onPressed: () {},
            ),
        );
    }
}

Future<_AfterMenu> showEditDialog(BuildContext context) {
    return showDialog<_AfterMenu>(
        context: context,
        builder: (BuildContext context) =>
            SimpleDialog(
                title: Text("Edit Song"),
                children: <Widget>[
                    SimpleDialogOption(
                        child: Row(
                            children: <Widget>[
                                Icon(Icons.play_arrow, size: 16),
                                SizedBox(width: 8),
                                Text("Play next"),
                            ],
                        ),
                        onPressed: () => Navigator.of(context).pop(_AfterMenu(playNext: true)),
                    ),
                    SimpleDialogOption(
                        child: Row(
                            children: <Widget>[
                                Icon(Icons.delete, size: 16),
                                SizedBox(width: 8),
                                Text("Remove"),
                            ],
                        ),
                        onPressed: () => Navigator.of(context).pop(_AfterMenu(remove: true)),
                    ),
                ]

            ),
    );
}
