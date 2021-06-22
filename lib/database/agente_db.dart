import 'package:app_covid/model/agente.dart';
import 'package:flutter/cupertino.dart';

class AgenteDAO {
  static final List<Agente> _agentes = List();

  static adicionar(Agente p) {
    _agentes.add(p);
  }

  static Agente getPaciente(int index) {
    return _agentes.elementAt(index);
  }

  static void atualizar(Agente p) {
    debugPrint('novo agente ' + p.toString());
    debugPrint('lista antiga $_agentes');
    _agentes.replaceRange(p.id, p.id + 1, [p]);
    debugPrint('lista nova $_agentes');
  }

  static get listarAgentes {
    return _agentes;
  }
}
