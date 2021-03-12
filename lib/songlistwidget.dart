import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'musicio.dart';
import 'dialogs.dart';
import 'queue.dart';

enum WhatDo {
    PlayNext,
    Remove,
}

List<Widget> getSongListWidget(BuildContext context, {
    String name,
    Set<SongInfo> songs,
    void Function(SongInfo song) onRemove,
    void Function() onChange
}) {
    Set<SongInfo> _songs;
    if (songs == null || songs.isEmpty) {
        if (name == null || name.isEmpty)
            return [];
        _songs = Playlists.songs(name);
    } else {
        _songs = songs;
    }

    return List<Widget>.from(_songs.map(
        (song) => Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Text(
                                song.uri,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                )
                            ),
                            Text(
                                Duration(milliseconds: int.parse(song.duration)).toString(),
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
                                    globalQueue.playNext(song);
                                    if (onChange != null)
                                        onChange();
                                    break;
                                case WhatDo.Remove:
                                    globalQueue.remove(song);
                                    if (onRemove != null)
                                        onRemove(song);
                                    if (onChange != null)
                                        onChange();
                                    break;
                            }
                        }),
                    )
                ]
            ),
        ),
    ));
}
