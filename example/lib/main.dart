// Copyright 2017 Ashraff Hathibelagal.
// Use of this source code is governed by an Apache license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:launcher_assist/launcher_assist.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var numberOfInstalledApps;
  List<AppInfo> installedApps;
  var wallpaper;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Launcher Assist'),
          ),

          body: FutureBuilder<List<AppInfo>>(
            future: LauncherAssist.getAllApps(),
            builder: (context, state) {
              if (!state.hasData) {
                return Center(child: Text('Loaging'),);
              }
              return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) => Card(child: Column(children: <Widget>[
                Text(state.data[index].label),
                if(state.data[index].banner != null) Image.memory(state.data[index].banner),
                if(state.data[index].icon != null) Image.memory(state.data[index].icon),
              ],),));
            },
          ))
    );
  }
}
