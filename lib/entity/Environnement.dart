import 'Site.dart';

final List<String> _environnement = [
  'Ordinateur',
  'Mail',
  'Logiciel',
  'Administration',
  'Commerce',
  'Web',
  'Temporaire',
];
enum env {
  Ordinateur,
  Mail,
  Logiciel,
  Administration,
  Commerce,
  Web,
  Temporaire,
}

class Environnement {
  String name;
  int id;
  List<Site> sites = [];

  Environnement(this.name);

  static List<Environnement> getAll() {
    List<Environnement> environnements = [];
    _environnement.forEach((name) {
      environnements.add(Environnement(name));
    });
    return environnements;
  }
}
