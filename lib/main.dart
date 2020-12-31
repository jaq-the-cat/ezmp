import 'package:flutter/material.dart';
import 'playlist.dart';

const Map<String, List<String>> playlists = {
    "Playlist 1": ["/path/to/song/1", "/path/to/song/2"],
    "Playlist 2": ["/path/to/song/1", "/path/to/song/2", "/path/to/song/3"],
    "Playlist 3": ["/path/to/song/1"],
    "Playlist 4": [],
};

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

    bool newPlaylistOpen = false;

    List<Widget> makePlaylistWidgets() {
        List<Widget> list = [];
        for (String name in playlists.keys)
            list.add(PlaylistItem(name));
        if (!newPlaylistOpen) {
            list.add(
                Form(
                    child: Row(
                        children: <Widget>[
                            TextFormField(),
                            ElevatedButton.icon(
                                icon: Icon(Icons.check),
                                label: Text("Create"),
                                onPressed: null,
                            ),
                        ],
                    ),
                ),
            );
        }
        return list;
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.title),
            ),
            body: ListView(
                children: makePlaylistWidgets(),
            ),
            floatingActionButton: ElevatedButton.icon(
                icon: Icon(Icons.add),
                label: Text("New Playlist"),
                onPressed: () {},
            )
        );
    }
}

class PlaylistItem extends StatelessWidget {

    PlaylistItem(this.name, {Key key}) : super(key: key);

    final String name;

    @override
    Widget build(BuildContext context) {
        return TextButton(
            onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlaylistPage(name))
                );
            },
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
