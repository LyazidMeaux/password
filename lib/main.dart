import 'package:flutter/material.dart';

import 'Categorie.dart';
import 'DataContainerWidget.dart';
import 'SiteList.dart';
import 'SiteWidget.dart';

void main() => runApp(Choix()); // 372

class Choix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var categorie = new Categorie('Navigation');

    return MaterialApp(
      title: 'Password',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.redAccent,
        brightness: Brightness.light,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
          labelStyle: TextStyle(color: Colors.blueGrey),
        ),
      ),
      home: categorie,
      /*
      home: BlocProvider(
        bloc: _bloc,
        child: SiteList(
          title: 'BLoC',
          messageStream: _bloc.messageStream,
        ),
      ),
      */

      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: true,
      showPerformanceOverlay: false,
      /*
      routes: <String, WidgetBuilder>{
        '/SiteList': (context) => SiteList(),
        //     '/SiteDetail': (context) => SiteDetail(),
      },
      */
      onGenerateRoute: handleRoute,
    );
  }

  Route<dynamic> handleRoute(RouteSettings routeSettings) {
    List<String> nameParam = routeSettings.name.split(':');
    assert(nameParam.length == 2);
    String name = nameParam[0];
    assert(name != null);
    //int id = int.parse(nameParam[1]);
    String parameter = nameParam[1];
    Widget childWidget;
    childWidget = (name == '/SiteList/')
        ? SiteList(parameter) //
        //? CustomerWidget(10)
        : SiteWidget(parameter); // OrderWidgetWithParameter(id);

    return MaterialPageRoute(
        builder: (context) => DataContainerWidget(child: childWidget));
  }
}
