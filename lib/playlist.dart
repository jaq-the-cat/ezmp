import 'package:flutter/material.dart';

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
                        child: Column(
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
