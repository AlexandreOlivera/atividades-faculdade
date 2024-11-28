import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/filme.dart';

class ListaFilmes extends StatefulWidget {
  @override
  _ListaFilmesState createState() => _ListaFilmesState();
}

class _ListaFilmesState extends State<ListaFilmes> {
  List<Filme> filmes = [];

  @override
  void initState() {
    super.initState();
    _carregarFilmes();
  }

  void _carregarFilmes() async {
    final dbHelper = DBHelper();
    final lista = await dbHelper.listarFilmes();
    setState(() {
      filmes = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Filmes')),
      body: ListView.builder(
        itemCount: filmes.length,
        itemBuilder: (context, index) {
          final filme = filmes[index];
          return ListTile(
            title: Text(filme.titulo),
            subtitle: Text('${filme.ano} - ${filme.genero}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await DBHelper().deletarFilme(filme.id!);
                _carregarFilmes();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cadastro').then((_) => _carregarFilmes());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
