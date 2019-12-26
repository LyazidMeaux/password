import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';

import 'Storage.dart';
import 'entity/Site.dart';

class Bloc {
  List<Site> sites = [];
  Bloc() {
    _upActionStreamController.stream.listen(_handleUp);
    _downActionStreamController.stream.listen(_handleDown);
  }
  List<Site> initSiteList() {
    sites = [];
    Storage storage = Storage();

    storage.readCounter().then((String data) {
      int counter = 0;
      //debugPrint('Data read: $data');
      //  _sites.clear();
      List<dynamic> jsonResult = json.decode(data);
      //debugPrint('Json: ${jsonResult.runtimeType}');
      jsonResult.forEach((item) {
        sites.add(Site.fromJson(item));
        counter++;
      });
      print('$counter sites found');
    });

    updateUpDownButton();
    return sites;
  }

  void dispose() {
    _upActionStreamController.close();
    _downActionStreamController.close();
  }

  void _handleUp(Site Site) {
    swap(Site, true);
    updateUpDownButton();

    sitesSubject.add(sites);
    _messageSubject.add(Site.name + ' moved up');
  }

  void _handleDown(Site Site) {
    swap(Site, false);
    updateUpDownButton();

    sitesSubject.add(sites);
    _messageSubject.add(Site.name + ' move down');
  }

  void swap(Site Site, bool up) {
    int idx = sites.indexOf(Site);
    sites.remove(Site);
    sites.insert(up ? idx - 1 : idx + 1, Site);
  }

  void updateUpDownButton() {
    for (int idx = 0, lastIdx = sites.length - 1; idx <= lastIdx; idx++) {
      Site site = sites[idx];
      //site.upButton = (idx > 0);
      //site.downButton = (idx < lastIdx);
    }
  }

  /// SINK
  final _upActionStreamController = StreamController<Site>();
  Sink<Site> get upAction => _upActionStreamController.sink;

  final _downActionStreamController = StreamController<Site>();
  Sink<Site> get downAction => _downActionStreamController.sink;

  /// STREAM
  final sitesSubject = BehaviorSubject<List<Site>>();
  Stream<List<Site>> get siteListStream => sitesSubject.stream;

  final _messageSubject = BehaviorSubject<String>();
  Stream<String> get messageStream => _messageSubject.stream;
}
