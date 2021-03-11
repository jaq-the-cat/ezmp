import 'package:flutter/material.dart';
import 'songlistwidget.dart';
import 'queue.dart';

class QueuePage extends StatefulWidget {
    @override
    QueuePageState createState() => QueuePageState();
}

class QueuePageState extends State<QueuePage> {
    Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text("Queue"),
        ),
        body: ListView(
            children: getSongListWidget(context, globalQueue.songs.toSet(), onChange: () => setState(() {})),
        ),
        persistentFooterButtons: [
            TextButton.icon(
                icon: Icon(Icons.shuffle),
                label: globalQueue.shuffle ? Text("Shuffle on") : Text("Shuffle off"),
                onPressed: () => setState(() => globalQueue.toggleShuffle()),
            ),
            IconButton(
                icon: globalQueue.playing ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                color: Colors.deepOrange,
                onPressed: () => setState(() => globalQueue.togglePlayPause()),
            ),
        ]
    );
}

Widget openQueuePageButton(BuildContext context) => TextButton.icon(icon: Icon(Icons.queue), label: Text("Queue"), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => QueuePage())));
