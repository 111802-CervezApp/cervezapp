import 'package:cervezapp2/src/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/sizes.dart';

class SaveCervezasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guardar'),
      ),
      body: Container(
        child: _FormSave(),
      ),
    );
  }
}

class _FormSave extends StatelessWidget {
  final _FormKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final tipoController = TextEditingController();
  final saborController = TextEditingController();
  final ibuController = TextEditingController();
  final abvController = TextEditingController();
  final precioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Form(
            key: _FormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: nombreController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese el nombre";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Nombre",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: tipoController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese el tipo";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Tipo",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: saborController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese el sabor";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Sabor",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: ibuController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese el IBU";
                    }
                    if (int.tryParse(value) == null) {
                      return "Solo se permiten números";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "IBU",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: abvController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese el ABV";
                    }
                    if (int.tryParse(value) == null) {
                      return "Solo se permiten números";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "ABV",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: precioController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese el precio";
                    }
                    if (int.tryParse(value) == null) {
                      return "Solo se permiten números";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Precio",
                    border: OutlineInputBorder(),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_FormKey.currentState!.validate()) {
                          print("valido");
                          await FirebaseFirestore.instance
                              .collection("cervezas")
                              .add({
                            'nombre': nombreController.text,
                            'tipo': tipoController.text,
                            'sabor': saborController.text,
                            'ibu': ibuController.text,
                            'abv': abvController.text,
                            'precio': precioController.text
                          }).then((_) {
                            var snackBar = SnackBar(
                              content: Text("Guardado con exito"),
                              action: SnackBarAction(
                                  label: "Ok",
                                  textColor: colorAccent,
                                  onPressed: () {}),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pop(context);
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        backgroundColor: colorPrincipal,
                        foregroundColor: colorSecundario,
                        side: BorderSide(color: colorSecundario),
                        padding: EdgeInsets.symmetric(vertical: buttonHeight),
                      ),
                      child: Text('Guardar')),
                ),
              ],
            )),
      ),
    );
  }
}
