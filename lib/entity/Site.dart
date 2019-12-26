import 'dart:convert';

import 'package:flutter/material.dart';

import '../Utils.dart';

class Site {
  String id;
  String name;
  String mail;

  String address;
  String username;
  String userId;
  String password;
  String keyId;

  Site({
    this.id,
    this.name,
    this.mail,
    this.address,
    this.username,
    this.userId,
    this.password,
    this.keyId,
  }) {
    if (this.id == null) this.id = getStamp();
  }

  operator ==(other) =>
      (other is Site && other.address == address && other.password == password);

  int get hashCode => address.hashCode ^ password.hashCode;

  Site.random() {
    name = 'Http';
    mail = 'LMG';

    address = 'http://lyazid.fr';
    username = 'lyazid';
    userId = '';
    String mot = mots[next(0, mots.length)];
    password = mot.substring(0, 1).toUpperCase() +
        mot.substring(1, mot.length) +
        '-' +
        next(1000, 9999).toString();
    keyId = '';
    id = getStamp();
  }

  Site.fromJson(String jsonText) {
    Site site = null;
    var error = null;
    try {
      var decoded = json.decode(jsonText);
      this.id = decoded['id'];

      this.name = decoded['name'];
      this.mail = decoded['mail'];
      this.address = decoded['address'];
      this.username = decoded['username'];
      this.userId = decoded['userId'];
      this.password = decoded['password'];
      this.keyId = decoded['keyId'];
    } catch (e) {
      debugPrint('ERROR on Site.<fromJson>: $e');
      error = e.toString();
    }
  }

  factory Site.fromFactoryJson(String jsonText) {
    Site site;
    var error;
    try {
      debugPrint('JSON TEXT: $jsonText');
      var decoded = json.decode(jsonText);
      debugPrint('DECODED: type: ${decoded.runtimeType} value: $decoded');
      site = decoded;
      debugPrint('RESULT :  ${site.toString()}');
      return site;
    } catch (e) {
      debugPrint('ERROR on Site.<fromJson>: $e');
      error = e.toString();
    }
    return null;
  }

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name': name,
        'mail': mail,
        'address': address,
        'username': username,
        'userId': userId,
        'password': password,
        'keyId': keyId,
      };

  List<Site> getAllSite(String jsonTextList) {
    List<Site> sites = [];
    List<dynamic> items = json.decode(jsonTextList);
    if (items != null) {
      items.forEach((item) {
        sites.add(Site.fromJson(item));
      });
    }
    return sites;
  }
}

final mots = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
];
