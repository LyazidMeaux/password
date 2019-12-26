/*
 * Copyright (c) 2019. Libre de droit
 */
import 'dart:convert';

import 'package:flutter/material.dart';

import 'Storage.dart';
import 'entity/Site.dart';

class SiteWidget extends StatefulWidget {
  final String siteId;
  SiteWidget(this.siteId);
  SiteWidgetState createState() => SiteWidgetState(siteId);
}

class SiteWidgetState extends State<SiteWidget> {
  List<Site> sites = [];
  Site site;
  String siteId;

  SiteWidgetState(this.siteId) {}

  @override
  void initState() {
    super.initState();
    Storage storage = Storage();
    storage.readCounter().then((String data) {
      int counter = 0;
      List<dynamic> jsonResult = json.decode(data);
      jsonResult.forEach((item) {
        Site _site = Site.fromJson(item);
        sites.add(_site);
        if (_site.id == siteId) {
          setState(() {
            site = _site;
            print('Editing Site Id: ${site.id}');
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (site == null) return Text("Loading");

    return Scaffold(
      // TODO : Mettre le nom de la catégorie
      appBar: AppBar(title: Text('Site')),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: AddressWidget(site: site, onSaved: _onSaved),
            )
          ],
        ),
      ),
    );
  }

  _onSaved(Site address) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Address'),
          content: Text(address.toString()),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Close'),
            )
          ],
        );
      },
    );
  }
}

class AddressWidget extends StatefulWidget {
  Site _site;
  ValueChanged<Site> _onSaved;

  AddressWidget({
    Key key,
    @required Site site,
    @required ValueChanged<Site> onSaved,
  }) : super(key: key) {
    this._site = site;
    this._onSaved = onSaved;
  }

  @override
  AddressWidgetState createState() => AddressWidgetState(_site);
}

class AddressWidgetState extends State<AddressWidget> {
  final _formKey = GlobalKey<FormState>();
  final Site site;

  TextEditingController nameTextController;
  TextEditingController mailTextController;
  TextEditingController colorTextController;
  TextEditingController iconTextController;
  TextEditingController addressTextController;
  TextEditingController usernameTextController;
  TextEditingController userIdTextController;
  TextEditingController passwordTextController;
  TextEditingController keyIdTextController;

  AddressWidgetState(this.site) {
    if (site == null) return;
    nameTextController = TextEditingController(text: site.name);
    mailTextController = TextEditingController(text: site.mail);
    addressTextController = TextEditingController(text: site.address);
    usernameTextController = TextEditingController(text: site.username);
    userIdTextController = TextEditingController(text: site.userId);
    passwordTextController = TextEditingController(text: site.password);
    keyIdTextController = TextEditingController(text: site.keyId);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> formWidgetList = new List();

    formWidgetList.add(createNameWidget());
    formWidgetList.add(createMailWidget());
    formWidgetList.add(createAddressWidget());
    formWidgetList.add(createUsernameWidget());
    formWidgetList.add(createUserIdWidget());
    formWidgetList.add(createPasswordWidget());
    formWidgetList.add(createKeyIdWidget());

    formWidgetList.add(Text(''));
    formWidgetList.add(ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RaisedButton(
          onPressed: () {},
          child: Text('Password'),
        ),
        RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Site address = createDataObjectFromFormData(site.id);
              Storage.save(address).then((onValue) {
                onValue ? print('Sauvegarde OK') : print('Sauvegarde KO');
              });

              Navigator.pop(context);
              // TODO : Sauvegarder les modifications.
            }
          },
          child: Text('Save'),
        ),
      ],
    ));

    return Form(
      key: _formKey,
      child: Column(children: formWidgetList),
    );
  }

  Site createDataObjectFromFormData(String id) {
    return Site(
        id: id,
        name: nameTextController.text,
        mail: mailTextController.text,
        address: addressTextController.text,
        username: usernameTextController.text,
        userId: userIdTextController.text,
        password: passwordTextController.text,
        keyId: keyIdTextController.text);
  }

  Widget createNameWidget() {
    return getFieldText(
      controller: nameTextController,
      label: 'Cible',
      info: 'Nom de la cible',
    );
  }

  Widget createMailWidget() {
    // TODO : Mettre une boite d'autocompletion
    return getFieldText(
      controller: mailTextController,
      label: 'EMail',
      info: 'Compte EMail',
    );
  }

  Widget createAddressWidget() {
    return getFieldText(
      controller: addressTextController,
      label: 'Adresse Web',
      info: 'Adreese du site',
    );
  }

  Widget createUsernameWidget() {
    return getFieldText(
      controller: usernameTextController,
      label: 'Utilisateur',
      info: 'Nom d\'utilisateur',
    );
  }

  Widget createPasswordWidget() {
    return getFieldText(
      controller: passwordTextController,
      label: 'Mot de passe',
      info: 'Not de passe',
    );
  }

  Widget createKeyIdWidget() {
    return getFieldText(
      controller: keyIdTextController,
      label: 'Clé logiciel',
      info: 'Reference de la clé',
    );
  }

  Widget createUserIdWidget() {
    return getFieldText(
      controller: userIdTextController,
      label: 'UserId',
      info: 'Identifiant utilisateur',
    );
  }

  Widget getFieldText({
    TextEditingController controller,
    String label,
    String info = '',
    bool mandatory = false,
  }) {
    return Container(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty && mandatory) {
              return 'Saisie obligatoire.';
            }
          },
          decoration: InputDecoration(
              labelText: label,
              hintText: info,
              labelStyle: TextStyle(fontSize: 24.0),
              contentPadding: EdgeInsets.only(top: 30.0, left: 20.0)),
          onSaved: (String value) {},
          controller: controller,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ));
  }
}
