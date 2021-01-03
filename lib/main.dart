import 'package:flutter/material.dart';
import 'playlist.dart';

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

    Map<String, List<String>> playlists = {
        "Playlist 1": ["/path/to/song/1", "/path/to/song/2"],
        "Playlist 2": ["/path/to/song/1", "/path/to/song/2", "/path/to/song/3"],
        "Playlist 3": ["/path/to/song/1"],
        "Playlist 4": [],
    };

    Future<void> heldOnPlaylist(String playlist) async {
        return showDialog<void>(
            context: context,
            builder: (BuildContext context) {
                return SimpleDialog(
                    title: Text("Manage $playlist"),
                    children: <Widget>[
                        SimpleDialogOption(
                            child: Text("Rename"),
                            onPressed: () => renamePlaylist(playlist).then((newName) {
                                if (newName != "" && !playlists.containsKey(newName))
                                    setState(() => playlists[newName] = playlists.remove(playlist));
                                Navigator.of(context).pop();
                            }),
                        ),
                        SimpleDialogOption(
                            child: Text("Delete"),
                            onPressed: () => confirmDelete(playlist).then((selected) {
                                if (selected) Navigator.of(context).pop();
                            }),
                        )
                    ]
                );
            }
        );
    }

    Future<String> renamePlaylist(String playlist) async {
        final ctrl = TextEditingController();
        return showDialog<String>(
            context: context,
            builder: (BuildContext context) {
                return Dialog(
                    child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        shrinkWrap: true,
                        children: <Widget>[
                            Form(
                                child: Column(
                                    children: <Widget>[
                                        TextFormField(
                                            autofocus: true,
                                            controller: ctrl,
                                        ),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                                TextButton(
                                                    child: Text("Cancel"),
                                                    onPressed: () => Navigator.of(context).pop(""),
                                                ),
                                                TextButton(
                                                    child: Text("Rename"),
                                                    onPressed: () => Navigator.of(context).pop(ctrl.text),
                                                ),
                                            ]
                                        )
                                    ]
                                )
                            )
                        ],
                    )
                );
            }
        );
    }

    Future<bool> confirmDelete(String playlist) async {
        return showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Delete Playlist"),
                    content: Container(
                        padding: EdgeInsets.all(15),
                        child: Text("Are you sure you would like to delete $playlist?"),
                    ),
                    actions: <Widget>[
                        TextButton(
                            child: Text("CANCEL"),
                            onPressed: () => Navigator.of(context).pop(false),
                        ),
                        TextButton(
                            child: Text("ACCEPT"),
                            onPressed: () {
                                setState(() => playlists.remove(playlist));
                                Navigator.of(context).pop(true);
                            },
                        ),
                    ]
                );
            }
        );
    }

    List<Widget> makePlaylistWidgets() {
        List<Widget> list = [];
        for (String name in playlists.keys)
            list.add(PlaylistItem(name, playlists[name], this.heldOnPlaylist));
        if (newPlaylistOpen) {
            list.add(
                Form(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                            children: <Widget>[
                                Expanded(
                                    child: TextFormField(
                                        controller: nameController,
                                    ),
                                ),
                                TextButton(
                                    child: Text("Create"),
                                    onPressed: () {
                                        setState(() {
                                            playlists[nameController.text] = [];
                                            nameController.clear();
                                            newPlaylistOpen ^= true;
                                        });
                                    },
                                )
                            ]
                        )
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

    PlaylistItem(this.name, this.songs, this.removeFromPlaylist, {Key key}) : super(key: key);

    final String name;
    final List<String> songs;
    final Function(String) removeFromPlaylist;

    @override
    Widget build(BuildContext context) {
        return TextButton(
            onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlaylistPage(name, songs))
                );
            },
            onLongPress: () => removeFromPlaylist(name),
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
