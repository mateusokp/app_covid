import 'package:app_covid/screens/android/paciente/paciente_list.dart';
import 'package:app_covid/screens/android/agente/agente_list.dart';
import 'package:flutter/material.dart';
import 'package:app_covid/screens/android/login_screen.dart';
class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DASHBOARD'),
        actions: <Widget>[
          InkWell(
            onTap: (){

              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Login()
              ));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          _msgSuperiorTXT(),
          _imgCentral(),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
              _ItemElemento('PACIENTES',Icons.accessibility_new, onClick: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PacienteList()
                  ));
              }),
              _ItemElemento('RESULTADOS',Icons.check_circle_outline, onClick: (){
                debugPrint('resultados...');
              }),
            ],),
          ),
          Container(
            height: 120,
            alignment: Alignment.topLeft,
            child: _ItemElemento('AG. DE SAUDE',Icons.accessibility_new, onClick: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AgenteList()
                    ));
                }),
          ),
        ],),
      ),
    );
  }

  Widget _imgCentral(){
    return Padding(
            padding: EdgeInsets.all(16.0),
            child: Image.asset('images/CovidTest.png')
          );
  }
  Widget _msgSuperiorTXT(){
      return Container(
          alignment: Alignment.topRight,
          padding: EdgeInsets.all(8.0),
          child: Text('Checklist para o COVID-19', style: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),)
        );
  }
}

class _ItemElemento extends StatelessWidget {

  final String titulo;
  final IconData icone;
  final Function onClick;

  _ItemElemento(this.titulo, this.icone, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              color: Colors.blue,
              elevation: 10.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: InkWell(
                onTap: this.onClick,
                child: Container(
                  width: 150,
                  height: 80,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[ Icon(this.icone,
                    color: Colors.white,
                    ),
                    Text(this.titulo, style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                      ),)
                    ]
                  ),
                ),
              ),
            ),
          );
    }
  }
