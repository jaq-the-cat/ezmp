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
                    Row(
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
                ] + widget.songs.map(
                    (songName) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(left: 12.5),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Text(
                                                songName,
                                                style: TextStyle(
                                                    fontSize: 17.5,
                                                    color: Colors.black54,
                                                )
                                            ),
                                            Text(
                                                "XX:XX",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                )
                                            ),
                                        ],
                                    ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.play_arrow),
                                    color: Colors.deepOrange,
                                    onPressed: () {},
                                )
                            ],
                        );
                    }
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
