import 'package:flutter/material.dart';

import 'Bloc.dart';

class BlocProvider extends InheritedWidget {
  final Bloc bloc;

  BlocProvider({Key key, @required this.bloc, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static Bloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bloc;
}
