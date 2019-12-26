/*
 * Copyright (c) 2019. Libre de droit
 */
import 'dart:core';

import 'package:flutter/material.dart';

import 'Provider.dart';
import 'entity/Environnement.dart';

class DataContainerWidget extends InheritedWidget {
  static List<Environnement> getAllEnvironnements() {
    return Provider.getAllEnvironnement();
  }

  DataContainerWidget({Key key, @required Widget child})
      : assert(child != null),
        super(key: key, child: child) {
    List<Environnement> environnements = Provider.getAllEnvironnement();
  }

/*

  Site getCustomer(int id) {
    print('Loading Customer.id: $id');
    Site customer = customerList.firstWhere((customer) => customer.id == id,
        orElse: () => Customer.empty());
    print(" find ${customer.id}: ${customer.name}");
    return customer;
  }

  Order getOrder(Customer customer, int id) {
    return customer.orders
        .firstWhere((order) => order.id == id, orElse: () => Order.empty());
  }

  Customer getCustomerForOrderId(int id) {
    return customerList.firstWhere((customer) => customerHasOrderId(customer, id),
        orElse: () => Customer.empty());
  }

  bool customerHasOrderId(Customer customer, int id) {
    Order order = customer.orders
        .firstWhere((order) => order.id == id, orElse: () => Order.empty());
    return order.id != 0;
  }
*/
  static DataContainerWidget of(BuildContext context) {
    //customerList = Provider.getAllEnvironnement();
    return context.inheritFromWidgetOfExactType(DataContainerWidget)
        as DataContainerWidget;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
