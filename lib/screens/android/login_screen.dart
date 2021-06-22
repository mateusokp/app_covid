import 'package:flutter/material.dart';
import 'package:app_covid/screens/android/dashboard_screen.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist para o COVID-19'),
      ),
      body: SingleChildScrollView(
          child: Container(
          padding: EdgeInsets.all(25.0),
          width: double.infinity,
          child: Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Text('Sign In', 
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'E-mail'
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Senha'
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: RaisedButton(
                      onPressed: (){

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Dashboard()
                        ));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)
                      ),
                      elevation: 5.0,
                      color: Colors.blue,
                      padding: EdgeInsets.all(20.0),
                      child: Text('LOGIN', style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
