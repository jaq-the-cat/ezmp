import 'package:flutter/material.dart';

const List<String> playlists = [
    "Playlist 1",
    "Playlist 2",
    "Playlist 3",
    "Playlist 4",
    "Playlist 5",
    "Playlist 6",
    "Playlist 7",
    "Playlist 8",
    "Playlist 9",
];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'EZMP',
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: HomePage(title: 'EZMP'),
        );
    }
}

class HomePage extends StatefulWidget {
    HomePage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

    List<Widget> makePlaylistWidgets() {
        List<Widget> list = [];
        for (String name in playlists)
            list.add(PlaylistItem(name));
        return list;
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.title),
            ),
            body: Center(
                child: ListView(
                    children: <Widget>[
                        TextButton.icon(
                            icon: Icon(Icons.add),
                            label: Text("New Playlist"),
                            onPressed: () {},
                        )
                    ] + makePlaylistWidgets(),
                ),
            ),
        );
    }
}

class PlaylistItem extends StatelessWidget {

    PlaylistItem(this.name, {Key key}) : super(key: key);

    final String name;

    @override
    Widget build(BuildContext context) {
        return TextButton(
            onPressed: () {},
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text(
                        name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                        ),
                    ),
                    Icon(Icons.keyboard_arrow_right),
                ],
            ),
        );
    }
}
