import 'dart:io';

import 'package:app_covid/screens/android/agente/agente_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app_covid/model/agente.dart';
import 'package:app_covid/database/agente_db.dart';
import 'package:random_color/random_color.dart';

class AgenteList extends StatefulWidget {
  @override
  _PacienteListState createState() => _PacienteListState();
}

class _PacienteListState extends State<AgenteList> {
  @override
  Widget build(BuildContext context) {

    List<Agente> _agentes = AgenteDAO.listarAgentes;

    return Scaffold(
      appBar: AppBar(
          title: Text('AGENTES DE SAUDE'),
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
              itemCount: _agentes.length,
              itemBuilder: (context, index){
                final Agente p = _agentes[index];
                return ItemPaciente(p, onClick: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AgenteScreen(index: index))
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
            builder: (context) => AgenteScreen()
            )
          ).then((value) {
            
            setState(() {
              debugPrint('retornou do add ag');
            });
          });

          
        },
        ),
      
    );
  }
}

class ItemPaciente extends StatelessWidget {

  final Agente _agente;
  final Function onClick;
    
  ItemPaciente(this._agente, {@required this.onClick});


  Widget _avatarFotoPerfil(){

    RandomColor corRandom = RandomColor();
    Color cor = corRandom.randomColor(
      colorBrightness: ColorBrightness.light
    );

    var inicialNome = this._agente.nome[0].toUpperCase();
    if(this._agente.foto.length > 0){
      inicialNome = '';
    }
    return CircleAvatar(
            backgroundColor: cor,
            foregroundColor: Colors.white,
            backgroundImage: FileImage(File(this._agente.foto)),
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
          title: Text(this._agente.nome, 
            style: TextStyle(
              fontSize: 24
          ),),
          subtitle: Text(this._agente.email,
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
      onSelected: (ItensMenuListAgente selecionado){
        debugPrint('selecionadom ... $selecionado');
      } ,
      itemBuilder: (BuildContext context) => <PopupMenuItem<ItensMenuListAgente>>[
        const PopupMenuItem(
          value: ItensMenuListAgente.resultados,
          child: Text('Resultados'),
          ),
        const PopupMenuItem(
          value: ItensMenuListAgente.novo_checklist,
          child: Text('Novo Checklist'),
          )
      ],
    );
  }
}

enum ItensMenuListAgente {resultados, novo_checklist}