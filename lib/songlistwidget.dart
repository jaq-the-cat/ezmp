import 'package:flutter/material.dart';
import 'dialogs.dart';
import 'queue.dart';

@immutable
class _AfterMenu {
    _AfterMenu({this.playNext, this.remove});

    final bool playNext;
    final bool remove;
}

List<Widget> getSongListWidget(Set<String> songs, BuildContext context) => songs.map(
    (songName) => Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(left: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
                Column(
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
                IconButton(
                    icon: Icon(Icons.menu),
                    iconSize: 18,
                    onPressed: () => showEditDialog(
                        context,
                        () => Navigator.of(context).pop(_AfterMenu(playNext: true)),
                        () => Navigator.of(context).pop(_AfterMenu(remove: true)),
                    ).then((r) {
                        if (r.playNext == true)
                            globalQueue.playNext(songName);
                        else if (r.remove == true)
                            globalQueue.remove(songName);
                    }),
                )
            ]
        ),
    ),
).toList();
