import 'dart:io';

import 'package:flutter/material.dart';
import 'package:app_covid/model/paciente.dart';
import 'package:app_covid/database/paciente_db.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PacienteScreen extends StatefulWidget {
  int index;
  PacienteScreen({int index}) {
    this.index = index;

    if (this.index == null) {
      this.index = -1;
    }
  }

  @override
  _PacienteScreenState createState() => _PacienteScreenState();
}

class _PacienteScreenState extends State<PacienteScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cartaoController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Paciente _paciente;
  bool _isUpdate = false;

  @override
  Widget build(BuildContext context) {
    if (widget.index >= 0 && this._isUpdate == false) {
      debugPrint('editar index = ' + widget.index.toString());

      this._paciente = PacienteDAO.getPaciente(widget.index);
      this._paciente.id = widget.index;
      this._nomeController.text = this._paciente.nome;
      this._emailController.text = this._paciente.email;
      this._fotoPerfil = this._paciente.foto;
      this._idadeController.text = this._paciente.idade.toString();
      this._cartaoController.text = this._paciente.cartao;
      this._senhaController.text = this._paciente.senha;

      this._isUpdate = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ADICIONAR PACIENTE'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _fotoAvatar(context),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Nome obrigatorio';
                      }
                      return null;
                    },
                    controller: this._nomeController,
                    decoration: InputDecoration(labelText: "Nome"),
                    style: TextStyle(fontSize: 24)),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'E-mail obrigatorio';
                    }
                    return null;
                  },
                  controller: this._emailController,
                  decoration: InputDecoration(labelText: "E-mail"),
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Cartao SUS obrigatorio';
                      }
                      return null;
                    },
                    controller: this._cartaoController,
                    decoration: InputDecoration(labelText: "Cartao SUS"),
                    style: TextStyle(fontSize: 24)),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Idade obrigatorio';
                    }
                    return null;
                  },
                  controller: this._idadeController,
                  decoration: InputDecoration(labelText: "Idade"),
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Senha obrigatoria';
                    }
                    return null;
                  },
                  controller: this._senhaController,
                  decoration: InputDecoration(labelText: "Senha"),
                  style: TextStyle(fontSize: 24),
                  obscureText: true,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    elevation: 5.0,
                    color: Colors.lightBlue,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Paciente p = new Paciente(
                            widget.index,
                            this._nomeController.text,
                            this._emailController.text,
                            this._cartaoController.text,
                            int.tryParse(this._idadeController.text),
                            this._senhaController.text,
                            this._fotoPerfil);

                        if (widget.index >= 0) {
                          PacienteDAO.atualizar(p);
                          Navigator.of(context).pop();
                        } else {
                          PacienteDAO.adicionar(p);
                          Navigator.of(context).pop();
                        }
                      } else {
                        debugPrint('formulario invalido');
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Text('Salvar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fotoAvatar(BuildContext context) {
    return InkWell(
      onTap: () {
        alertTirarFoto(context);
        debugPrint('Tirar foto');
      },
      child: CircleAvatar(
        backgroundImage: AssetImage('images/avatar.png'),
        radius: 70,
        child: ClipOval(
            child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.file(File(this._fotoPerfil)))),
      ),
    );
  }

  alertTirarFoto(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('TIRAR FOTO?', style: TextStyle(fontWeight: FontWeight.bold)),
      content:
          Text('Tire uma foto ou escolha alguma na galeria para o seu perfil'),
      elevation: 5,
      actions: [
        FlatButton(
          child: Text('CAMERA'),
          onPressed: () {
            debugPrint('escolheu CAMERA');
            _obterImage(ImageSource.camera);
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('GALERIA'),
          onPressed: () {
            debugPrint('escolheu galeria');
            _obterImage(ImageSource.gallery);
            Navigator.of(context).pop();
          },
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  String _fotoPerfil = '';

  _obterImage(ImageSource source) async {
    final image = await ImagePicker().getImage(source: source);

    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.png,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.white,
              toolbarTitle: 'CORTAR IMAGEM',
              statusBarColor: Colors.lightBlue,
              backgroundColor: Colors.white));
      setState(() {
        this._fotoPerfil = cropped.path;
      });
    }
  }
}
