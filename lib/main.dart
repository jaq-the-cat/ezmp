import 'package:flutter/material.dart';
import 'playlistlist.dart';

void main() => runApp(App());

class App extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'EZMP',
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                brightness: Brightness.dark,
            ),
            home: PlaylistList(title: 'EZMP'),
        );
    }
}
