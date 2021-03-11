import 'package:flutter/material.dart';
import 'dialogs.dart';
import 'queue.dart';

enum WhatDo {
    PlayNext,
    Remove,
}

List<Widget> getSongListWidget(BuildContext context, Set<String> songs, {void Function(String songName) onRemove}) => songs.map(
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
                        () => Navigator.of(context).pop(WhatDo.PlayNext),
                        () => Navigator.of(context).pop(WhatDo.Remove),
                    ).then((r) {
                        switch (r) {
                            case WhatDo.PlayNext:
                                globalQueue.playNext(songName);
                                break;
                            case WhatDo.Remove:
                                globalQueue.remove(songName);
                                if (onRemove != null)
                                    onRemove(songName);
                                break;
                        }
                    }),
                )
            ]
        ),
    ),
).toList();
