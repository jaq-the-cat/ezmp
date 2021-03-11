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
    );
}

Widget openQueuePageButton(BuildContext context) => TextButton.icon(icon: Icon(Icons.queue), label: Text("Queue"), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => QueuePage())));
