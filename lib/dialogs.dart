import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'musicio.dart';

Future<String> _playlistNameDialogBuilder(BuildContext context, String confirmText, void Function(String) onConfirm) {
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
                                    decoration: InputDecoration(
                                        labelText: "Playlist Name",
                                        labelStyle: TextStyle(
                                            color: Colors.deepOrange,
                                        ),
                                        fillColor: Colors.deepOrange,
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                    color: Colors.deepOrange,
                                            ),
                                        ),
                                    ),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                        TextButton(
                                            child: Text("CANCEL"),
                                            onPressed: () => Navigator.of(context).pop(""),
                                        ),
                                        TextButton(
                                            child: Text(confirmText.toUpperCase()),
                                            onPressed: () {
                                                onConfirm(ctrl.text);
                                                Navigator.of(context).pop(ctrl.text);
                                            },
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

Future<String> newPlaylist(BuildContext context, void Function(String) onCreate) => _playlistNameDialogBuilder(context, "create", onCreate);

Future<String> renamePlaylist(BuildContext context, String playlist, void Function(String) onRename) async => _playlistNameDialogBuilder(context, "rename", onRename);

Future<bool> confirmDelete(BuildContext context, String playlist, Function onAccept) async {
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
                        child: Text("CONFIRM"),
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

Future<void> heldOnPlaylist(BuildContext context, String playlist, {Function onRename, Function onDelete}) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
            return SimpleDialog(
                title: Text("Manage $playlist"),
                children: <Widget>[
                    SimpleDialogOption(
                        child: Text("Rename"),
                        onPressed: () {
                            Navigator.of(context).pop();
                            onRename();
                        },
                    ),
                    SimpleDialogOption(
                        child: Text("Delete"),
                        onPressed: () {
                            Navigator.of(context).pop();
                            onDelete();
                        },
                    )
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

Future<Set<String>> showAddSongDialog(BuildContext context) {
    return showDialog<Set<String>>(
        context: context,
        builder: (BuildContext context) => _AddSongDialog(),
    );
}

class _AddSongDialog extends StatefulWidget {

    @override
    _AddSongState createState() => _AddSongState();
}

class _AddSongState extends State<_AddSongDialog> {

    Set<SongInfo> added = Set();

    Widget build(BuildContext context) {
        return  Dialog(
            child: FutureBuilder(
                future: Playlists.getSongs(),
                builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    return ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(15),
                        children: snapshot.data.map((SongInfo song) {
                            return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Text(
                                                song.uri,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                )
                                            ),
                                            Text(
                                                Duration(milliseconds: int.parse(song.duration)).toString(),
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
                                        onPressed: () => setState(() => added.add(song)),
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
                                        onPressed: () => Navigator.of(context).pop(added),
                                    ),
                                ],
                            ),
                        ],
                    );
                }
            )
        );
    }
}
