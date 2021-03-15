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
        body: getSongListWidget(context, songs: Future.value(globalQueue.songs), onChange: () => setState(() {})),
        bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                TextButton.icon(
                    icon: Icon(Icons.shuffle),
                    label: globalQueue.shuffle ? Text("Shuffle on") : Text("Shuffle off"),
                    onPressed: () => setState(() => globalQueue.toggleShuffle()),
                ),
                IconButton(
                    icon: Icon(Icons.skip_previous),
                    color: Colors.deepOrange,
                    onPressed: () => setState(() => globalQueue.previous()),
                ),
                IconButton(
                    icon: globalQueue.playing ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                    color: Colors.deepOrange,
                    onPressed: () => setState(() => globalQueue.togglePlayPause()),
                ),
                IconButton(
                    icon: Icon(Icons.skip_next),
                    color: Colors.deepOrange,
                    onPressed: () => setState(() => globalQueue.next()),
                ),
            ]
        ),
    );
}

Widget openQueuePageButton(BuildContext context) => TextButton.icon(
    icon: Icon(Icons.queue),
    label: Text("Queue"),
    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => QueuePage()))
);
