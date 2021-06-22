import 'dart:io';
import 'package:app_covid/screens/android/appcovid.dart';
import 'package:flutter/material.dart';
import 'package:app_covid/database/paciente_db.dart';
import 'package:app_covid/model/paciente.dart';
import 'package:app_covid/database/agente_db.dart';
import 'package:app_covid/model/agente.dart';

void main() {

  _geraPacientes(){

    Paciente p1 = Paciente(12, 'Louro', 'louro@teste', 'tx232', 18, 'teste22','');
    Paciente p2 = Paciente(12, 'Paulinho', 'pau@teste', 'tx232', 65, 'teste22','');
    Paciente p3 = Paciente(12, 'Paulinho', 'pau@teste', 'tx232', 65, 'teste22','');      

    PacienteDAO.adicionar(p1);
    PacienteDAO.adicionar(p2);
    PacienteDAO.adicionar(p3);

  }

  _geraAgentes(){

    Agente a1 = Agente(12, 'Doutor', 'doutor@teste', 'tx232', 18, 'teste22','');
    Agente a2 = Agente(12, 'Medico', 'medico@teste', 'tx232', 65, 'teste22','');
    Agente a3 = Agente(12, 'Pediatra', 'pediatra@teste', 'tx232', 65, 'teste22','');      

    AgenteDAO.adicionar(a1);
    AgenteDAO.adicionar(a2);
    AgenteDAO.adicionar(a3);

  }
  
  if(Platform.isAndroid){
    debugPrint('app no android');
    _geraAgentes();
    _geraPacientes();
    runApp(AppCovid());
  }
  else if(Platform.isIOS){
    debugPrint('app no IOS');
  }

  //runApp(MyApp());
}