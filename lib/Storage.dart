import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:password/entity/Site.dart';
import 'package:path_provider/path_provider.dart';

class Storage {
  static int pointer = 0;

  Future<String> get _localPath async {
    //getApplicationDocumentsDirectory().then((directory) => directory.path);
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _currentFile async {
    final path = await _localPath;
    final String filename = await listofFiles(current: true);
    debugPrint('Current file is $filename');
    return File('$path/$filename');
  }

  Future<File> get _nextFile async {
    final path = await _localPath;
    final String filename = await listofFiles(next: true);
    debugPrint('Next file is $filename');
    return File('$path/$filename');
  }

  Future<File> writeCounter(String data) async {
    final file = await _nextFile;
    return file.writeAsString('$data');
  }

  Future<String> readCounter() async {
    try {
      final file = await _currentFile;

      // Read the file.
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0.
      return '';
    }
  }

  // Make New Function
  Future<String> listofFiles({bool next = false, bool current = false}) async {
    final path = await _localPath;
    //directory = (await getApplicationDocumentsDirectory()).path;

    List<FileSystemEntity> files = Directory("$path/").listSync();

    for (FileSystemEntity file in files) {
      String fileName = file.toString();
      if (fileName.contains('/sites.')) {
        final int position = fileName.lastIndexOf('.') + 1;
        String extension = fileName.substring(position, fileName.length - 1);
        int attribut = int.tryParse(extension) ?? -1;
        if (attribut > pointer) {
          pointer = attribut;
        }
      }
    }

    if (next) {
      pointer++;
    }
    return ('sites.${pointer.toString()}');
  }

  /// Mise a jour du fichier
  static Future<bool> save(Site site) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;

      List<FileSystemEntity> files = Directory("$path/").listSync();

      for (FileSystemEntity file in files) {
        String fileName = file.toString();
        if (fileName.contains('/sites.')) {
          final int position = fileName.lastIndexOf('.') + 1;
          String extension = fileName.substring(position, fileName.length - 1);
          int attribut = int.tryParse(extension) ?? -1;
          if (attribut > pointer) {
            pointer = attribut;
          }
        }
      }

      final String currentFileName = ('sites.${pointer.toString()}');
      pointer++;
      final String nextFileName = ('sites.${pointer.toString()}');
      debugPrint('File $currentFileName --> $nextFileName');

      final file = File('$path/$currentFileName');

      String data = await file.readAsString();

      int counter = 0;
      List<Site> sites = [];

      List<dynamic> jsonResult = json.decode(data);

      jsonResult.forEach((item) {
        Site _site = Site.fromJson(item);

        if (_site.id == site.id) {
          _site = site;
          print('New Site! ${site.name} -  ${_site.id} ');
        } else {
          print('Old Site : ${_site.name} -  ${_site.id} -  ${site.id}  ');
        }
        sites.add(_site);
      });

      // Sauvegarde
      final File nextFile = File('$path/$nextFileName');
      List<String> items = [];

      sites.forEach((site) {
        //items.add(site.toMap());
        items.add(site.toJson());
      });
      String dataToSave = json.encode(items);
      String simpleData = dataToSave.replaceAll('\\', '');
      print('1-Data to write:\n$dataToSave');
      print('2-Data to write:\n$simpleData');
      nextFile.writeAsString('$dataToSave');
      return true;
    } catch (e) {
      // If encountering an error, return 0.
      print('Storage:save error ${e.toString()}');
      return false;
    }
  }
}
