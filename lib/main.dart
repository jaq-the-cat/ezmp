import 'package:flutter/material.dart';
import 'musicio.dart';
import 'playlist.dart';
import 'dialogs.dart';

final newPlaylistKey = GlobalKey<HomePageState>();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'EZMP',
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                brightness: Brightness.dark,
            ),
            home: HomePage(title: 'EZMP', key: newPlaylistKey),
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
    TextEditingController nameController = TextEditingController();

    Map<String, List<String>> playlists = getPlaylists();

    List<Widget> makePlaylistWidgets() {
        List<Widget> list = [];
        for (String name in playlists.keys)
            list.add(PlaylistItem(name, playlists[name], () {
                confirmDelete(
                    name,
                    () => setState(() => playlists.remove(name)),
                    context,
                );
        }));
        if (newPlaylistOpen) {
            list.add(
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        children: <Widget>[
                            Expanded(
                                child: TextFormField(
                                    autofocus: true,
                                    controller: nameController,
                                ),
                            ),
                            TextButton(
                                child: Text("Create"),
                                onPressed: () {
                                    setState(() {
                                        if (nameController.text != null && nameController.text != "") {
                                            playlists[nameController.text] = [];
                                            nameController.clear();
                                        }
                                        newPlaylistOpen ^= true;
                                    });
                                },
                            )
                        ]
                    )
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
                onPressed: () {
                    setState(() {
                        nameController.clear();
                        newPlaylistOpen ^= true;
                    });
                },
            )
        );
    }
}

class PlaylistItem extends StatelessWidget {

    PlaylistItem(this.name, this.songs, this.onLongPress, {Key key}) : super(key: key);

    final String name;
    final List<String> songs;
    final Function onLongPress;

    @override
    Widget build(BuildContext context) {
        return TextButton(
            onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlaylistPage(name, songs))
                );
            },
            onLongPress: onLongPress,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text(
                        name,
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
