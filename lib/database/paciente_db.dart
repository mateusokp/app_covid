import 'package:app_covid/model/paciente.dart';
import 'package:flutter/cupertino.dart';

class PacienteDAO {
  static final List<Paciente> _pacientes = List();

  static adicionar(Paciente p) {
    _pacientes.add(p);
  }

  static Paciente getPaciente(int index) {
    return _pacientes.elementAt(index);
  }

  static void atualizar(Paciente p) {
    debugPrint('novo paciente ' + p.toString());
    debugPrint('lista antiga $_pacientes');
    _pacientes.replaceRange(p.id, p.id + 1, [p]);
    debugPrint('lista nova $_pacientes');
  }

  static get listarPacientes {
    return _pacientes;
  }
}
