import 'package:flutter/material.dart';
import 'musicio.dart';
import 'dialogs.dart';
import 'queuepage.dart';
import 'playlist.dart';

class PlaylistList extends StatefulWidget {
    PlaylistList({Key key, this.title}) : super(key: key);

    final String title;

    @override
    PlaylistListState createState() => PlaylistListState();
}

class PlaylistListState extends State<PlaylistList> {

    bool newPlaylistOpen = false;
    TextEditingController nameController = TextEditingController();

    Map<String, Set<String>> playlists = getPlaylists();

    Widget newPlaylistForm(void Function() onCreate) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
            children: <Widget>[
                Expanded(
                    child: TextFormField(
                        autofocus: true,
                        controller: this.nameController,
                        cursorColor: Colors.deepOrange,
                    ),
                ),
                TextButton(
                    child: Text("Create"),
                    onPressed: onCreate,
                ),
            ],
        ),
    );

    Widget playlistItem(String name, Set<String> songs, {void Function() onLongPress}) => TextButton(
        onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlaylistPage(name, songs))
            );
        },
        onLongPress: onLongPress,
        child: Padding(
            padding: EdgeInsets.all(10.0),
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
        ),
    );

    List<Widget> makePlaylistWidgets() {
        List<Widget> list = [];
        for (String name in playlists.keys)
            list.add(playlistItem(name, playlists[name], onLongPress: () {
                confirmDelete(
                    name,
                    () => setState(() => playlists.remove(name)),
                    context,
                );
        }));
        if (newPlaylistOpen) {
            list.add(newPlaylistForm(() => setState(() {
                if (nameController.text != null && nameController.text != "") {
                    playlists[nameController.text] = Set();
                    nameController.clear();
                }
                newPlaylistOpen ^= true;
            })));
        }
        return list;
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.title),
                actions: [
                    openQueuePageButton(context),
                ],
            ),
            body: ListView(
                children: makePlaylistWidgets(),
            ),
            persistentFooterButtons: [
                TextButton.icon(
                    icon: Icon(Icons.add),
                    label: Text("New Playlist"),
                    onPressed: () {
                        setState(() {
                            nameController.clear();
                            newPlaylistOpen ^= true;
                        });
                    },
                )
            ],
        );
    }
}


