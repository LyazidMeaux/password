/*
 * Copyright (c) 2019. Libre de droit
 */

import 'entity/Environnement.dart';

class Provider {
  static List<Environnement> getAllEnvironnement() {
    return Environnement.getAll();
    // TODO : Chargement via un fichier
  }
}
