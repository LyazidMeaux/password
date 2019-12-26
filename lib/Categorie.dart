/*
 * Copyright (c) 2019. Libre de droit
 */
import 'package:flutter/material.dart';

import 'DataContainerWidget.dart';
import 'entity/Environnement.dart';
/*
import 'package:main/view/DataContainerWidget.dart';

import 'model/Customer.dart';
import 'model/Order.dart';
import 'model/Provider.dart';
*/

class Categorie extends StatelessWidget {
  final String title;

  var chapitre;

  Categorie(this.title, {Key key}) : super(key: key);

  void navigateToSite(BuildContext context, Environnement environnement) {
    debugPrint('Afficher la categorie: ${environnement.name}');
    Navigator.pushNamed(context, '/SiteList/:${environnement.name}');
  }

  ListTile createCustomerWidget(BuildContext context, Environnement environnement) {
    return ListTile(
      title: Text(
        environnement.name,
        style: TextStyle(fontSize: 28.0),
      ),
      //subtitle: Text(environnement.name),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        navigateToSite(context, environnement);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Environnement> environnements = DataContainerWidget.getAllEnvironnements();

    debugPrint('Number of environnement: ${environnements.length}');

    List<Widget> listView = [];
    for (int i = 0; i < environnements.length; i++) {
      listView.add(createCustomerWidget(context, environnements[i]));
      // TODO :  listView.add(Spacer()); mettre les deux dans un Flex

    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Mot de Passe'),
      ),
      body: Center(child: ListView(children: listView)),
    );
  }
}

class CustomerWidget extends StatelessWidget {
  int _id;
  CustomerWidget(this._id);

  void navigateToOrderSimple(BuildContext context) {
    debugPrint('');
    //Navigator.pushNamed(context, '/Chap24Order/:${order.id}');
  }

  ListTile createOrderListWidget(BuildContext context) {
    return ListTile(
      title: Text('order.description'),
      subtitle: Text(''),
      trailing: Icon(Icons.arrow_right),
      onTap: () => navigateToOrderSimple(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    DataContainerWidget data = DataContainerWidget.of(context);

    List<Widget> widgetList = [Text("A"), Text("A")];

    widgetList.insert(
      0,
      Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              'customer.name',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'customer.location',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'customer.orders.length Orders',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Info'),
      ),
      body: Center(
        child: ListView(
          children: widgetList,
        ),
      ),
    );
  }
}

/*

class OrderWidgetWithParameter extends StatelessWidget {
  int _id;
  OrderWidgetWithParameter(this._id);

  @override
  Widget build(BuildContext context) {
    DataContainerWidget data = DataContainerWidget.of(context);
    Customer customer = data.getCustomerForOrderId(_id);
    Order order = data.getOrder(customer, _id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Info'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Text(
              customer.name,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              customer.location,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(''),
            Text(
              order.description,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              '${order.frenchDate()}: \$${order.total}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

*/
