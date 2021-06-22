import 'dart:io';

import 'package:app_covid/screens/android/paciente/paciente_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app_covid/model/paciente.dart';
import 'package:app_covid/database/paciente_db.dart';
import 'package:random_color/random_color.dart';

class PacienteList extends StatefulWidget {
  @override
  _PacienteListState createState() => _PacienteListState();
}

class _PacienteListState extends State<PacienteList> {
  @override
  Widget build(BuildContext context) {

    List<Paciente> _pacientes = PacienteDAO.listarPacientes;

    return Scaffold(
      appBar: AppBar(
          title: Text('PACIENTES'),
      ),

      body: Column(children: [
        Container(
          child: TextField(
            style: TextStyle(fontSize: 15),
            decoration: InputDecoration(
              hintText: 'Pesquisar',
              prefixIcon: Icon(Icons.search)
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: ListView.builder(
              itemCount: _pacientes.length,
              itemBuilder: (context, index){
                final Paciente p = _pacientes[index];
                return ItemPaciente(p, onClick: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PacienteScreen(index: index))
                  ).then((value){
                    setState(() {
                      debugPrint('voltou do editar');
                    });
                  });
                },);
              }
            ),
          ),
        ),
      ],),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PacienteScreen()
            )
          ).then((value) {
            
            setState(() {
              debugPrint('retornou do add pac');
            });
          });

          
        },
        ),
      
    );
  }
}

class ItemPaciente extends StatelessWidget {

  final Paciente _paciente;
  final Function onClick;
    
  ItemPaciente(this._paciente, {@required this.onClick});

  Widget _avatarFotoPerfil(){

    RandomColor corRandom = RandomColor();
    Color cor = corRandom.randomColor(
      colorBrightness: ColorBrightness.light
    );

    var inicialNome = this._paciente.nome[0].toUpperCase();
    if(this._paciente.foto.length > 0){
      inicialNome = '';
    }
    return CircleAvatar(
            backgroundColor: cor,
            foregroundColor: Colors.white,
            backgroundImage: FileImage(File(this._paciente.foto)),
            radius: 22,
            child: Text(inicialNome, 
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 30),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => this.onClick(),
          leading: _avatarFotoPerfil(),
          title: Text(this._paciente.nome, 
            style: TextStyle(
              fontSize: 24
          ),),
          subtitle: Text(this._paciente.email,
            style: TextStyle(fontSize: 12),),
            trailing: _menu(),
        ),
        Divider(
          color: Colors.black,
          indent: 70,
          endIndent: 10,
          thickness: 1.0,
          height: 0
        ),
      ],
    );
  }

  Widget _menu(){
    return PopupMenuButton(
      onSelected: (ItensMenuListPaciente selecionado){
        debugPrint('selecionadom ... $selecionado');
      } ,
      itemBuilder: (BuildContext context) => <PopupMenuItem<ItensMenuListPaciente>>[
        const PopupMenuItem(
          value: ItensMenuListPaciente.resultados,
          child: Text('Resultados'),
          ),
        const PopupMenuItem(
          value: ItensMenuListPaciente.novo_checklist,
          child: Text('Novo Checklist'),
          )
      ],
    );
  }
}

enum ItensMenuListPaciente {resultados, novo_checklist}