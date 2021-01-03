import 'package:flutter/material.dart';
import 'musicio.dart';

Future<void> heldOnPlaylist(String playlist, Function onRename, Function onDelete, BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
            return SimpleDialog(
                title: Text("Manage $playlist"),
                children: <Widget>[
                    SimpleDialogOption(
                        child: Text("Rename"),
                        onPressed: onRename,
                        //onPressed: () => renamePlaylist(playlist).then((newName) {
                            //if (newName != "" && !playlists.containsKey(newName))
                                //setState(() => playlists[newName] = playlists.remove(playlist));
                            //Navigator.of(context).pop();
                        //}),
                    ),
                    SimpleDialogOption(
                        child: Text("Delete"),
                        onPressed: onDelete,
                        //onPressed: () => confirmDelete(playlist).then((selected) {
                            //if (selected) Navigator.of(context).pop();
                        //}),
                    )
                ]
            );
        }
    );
}

Future<String> renamePlaylist(String playlist, BuildContext context) async {
    final ctrl = TextEditingController();
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) {
            return Dialog(
                child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    shrinkWrap: true,
                    children: <Widget>[
                        Column(
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
                        ),
                    ],
                ),
            );
        }
    );
}

Future<bool> confirmDelete(String playlist, Function onAccept, BuildContext context) async {
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
                            onAccept();
                            Navigator.of(context).pop(true);
                        },
                    ),
                ]
            );
        }
    );
}

Future<dynamic> showEditDialog(BuildContext context, Function onPlayNext, Function onRemove) {
    return showDialog<dynamic>(
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
                        onPressed: onPlayNext,
                    ),
                    SimpleDialogOption(
                        child: Row(
                            children: <Widget>[
                                Icon(Icons.delete, size: 16),
                                SizedBox(width: 8),
                                Text("Remove"),
                            ],
                        ),
                        onPressed: onRemove,
                    ),
                ]

            ),
    );
}

Future<List<String>> showAddSongDialog(BuildContext context, Function onAdd) {
    return showDialog<List<String>>(
        context: context,
        builder: (BuildContext context) =>
            Dialog(
                child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(15),
                    children: getSongs().map((name) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Text(
                                            name,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                            )
                                        ),
                                        Text(
                                            "XX:XX",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white38,
                                            )
                                        ),
                                    ],
                                ),
                                IconButton(
                                    icon: Icon(Icons.add),
                                    iconSize: 16,
                                    onPressed: onAdd,
                                ),
                            ],
                        );
                    }).toList() + [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                                TextButton(
                                    child: Text("CANCEL"),
                                    onPressed: () => Navigator.of(context).pop(),
                                ),
                                TextButton(
                                    child: Text("DONE"),
                                    onPressed: () => Navigator.of(context).pop([]),
                                ),
                            ],
                        ),
                    ],
                ),
            ),
    );
}
