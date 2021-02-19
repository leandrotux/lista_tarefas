import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listaTarefas = [];

  _saveData() async {
    final diretorio = await getApplicationDocumentsDirectory();
    var arquivo = File("${diretorio.path}/dados.json");

    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = "Ir ao mercado";
    tarefa["realizada"] = false;
    _listaTarefas.add(tarefa);

    String dados = json.encode(_listaTarefas);
    arquivo.writeAsString(dados);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Tarefas"),
          backgroundColor: Colors.purple,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          elevation: 6,
          //mini: true,
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Adicionar Tarefas"),
                    content: TextField(
                      decoration:
                          InputDecoration(labelText: "Digite sua tarefa"),
                      onChanged: (text) {},
                    ),
                    actions: [
                      FlatButton(
                        child: Text("Cancelar"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      FlatButton(
                        child: Text("Adicionar"),
                        onPressed: () {
                          //salvar
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                });
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _listaTarefas.length,
                itemBuilder: (contex, index) {
                  return ListTile(
                    title: Text(_listaTarefas[index]),
                  );
                },
              ),
            )
          ],
        ));
  }
}
