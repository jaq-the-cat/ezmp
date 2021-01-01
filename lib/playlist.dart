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
                children: [],
            ),
            floatingActionButton: ElevatedButton.icon(
                icon: Icon(Icons.music_note),
                label: Text("Add Song"),
                onPressed: () {},
            )
        );
    }
}
