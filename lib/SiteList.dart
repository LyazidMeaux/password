/*
 * Copyright (c) 2019. Libre de droit
 */
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:password/entity/Site.dart';

import 'Storage.dart';

List<Site> _sites = [];
/*
class SiteListApp extends StatelessWidget {
  final String _environnement;

  SiteListApp(this._environnement);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SiteList('Password'),
    );
  }
}
*/

class SiteList extends StatefulWidget {
  String _environnement;
  SiteList(this._environnement, {Key key}) : super(key: key);

  Storage storage = Storage();
  SiteListState createState() => SiteListState();
}

class SiteListState extends State<SiteList> {
  @override
  void initState() {
    super.initState();
    _sites.clear();

    widget.storage.readCounter().then((String data) {
      setState(() {
        int counter = 0;
        //debugPrint('Data read: $data');
        //  _sites.clear();
        List<dynamic> jsonResult = json.decode(data);
        //debugPrint('Json: ${jsonResult.runtimeType}');
        jsonResult.forEach((item) {
          _sites.add(Site.fromJson(item));
          counter++;

//          debugPrint('Item: ${item.runtimeType}');
//          Site site = Site.fromJson(item);
//          debugPrint('Data: $item');
        });
        debugPrint('$counter sites found');
      });
    });
  }

  //final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  SiteListState() : super() {
    debugPrint('Constructor');
    for (int i = 1; i < 5; i++) {
      //_sites.add(Site.random());
    }
  }

  buildItem(Site site, {int index = -1}) {
    return ListTile(
      key: Key('ListTile:${site.hashCode.toString()}'),
      leading: CircleAvatar(
        child: Text(site.mail, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: getColor(site),
        //backgroundImage: NetworkImage(cat.imageSrc),
        radius: 32.0,
      ),
      title: Text(
        '${site.name}',
        style: TextStyle(fontSize: 25),
      ),
      subtitle: Text(
        getPassword(site),
        style: TextStyle(fontSize: 20.0),
      ),
      trailing: Container(
        color: Colors.lightBlueAccent,
        padding: EdgeInsets.all(0.0),
        margin: EdgeInsets.all(0.0),
        child: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/SiteDetail/:${site.id}');
            print('Opening this Tile');
          },
          icon: Icon(
            Icons.arrow_right,
            //size: 1,
          ),
        ),
      ),
      onLongPress: index != null ? () => _remove(index) : null,
    );
  }

  _add() {
    setState(() {
      _sites.add(Site.random());
      // TODO : Ajouter la sauvegarde dans le fichier
    });
  }

  _remove(int index) {
    setState(() {
      Site site = _sites[index];
      _sites.remove(site);
    });
  }

  Future<File> saveData() {
//  List<Map<String, dynamic>> items = [];
    List<String> items = [];

    _sites.forEach((site) {
      //items.add(site.toMap());
      items.add(site.toJson());
    });
    String dataToSave = json.encode(items);
    String simpleData = dataToSave.replaceAll('\\', '');
    debugPrint('Save data to json (${_sites.length})');
    debugPrint('Save data to json : \n$simpleData');

    setState(() {
      // refresh
    });
    return widget.storage.writeCounter(dataToSave);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('SiteList Build: ${_sites.length}');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._environnement),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              saveData();
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _sites.length,
        itemBuilder: (context, index) {
          var site = _sites[index];
          return Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.white,
            )),
            padding: EdgeInsets.all(0.0),
            margin: EdgeInsets.all(10.0),
            child: buildItem(_sites[index], index: index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  String getPassword(Site site) {
    if (site.userId != null && site.userId.trim().length > 0) {
      return site.userId + ' - ' + site.password;
    } else
      return site.password;
  }

  Color getColor(Site site) {
    if (site.userId != null && site.userId.trim().length > 0) {
      return Colors.orange;
    } else
      return Colors.greenAccent;
  }
}
