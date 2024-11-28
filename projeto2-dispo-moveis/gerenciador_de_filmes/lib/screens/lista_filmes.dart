import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListaFilmes extends StatefulWidget {
  @override
  _ListaFilmesState createState() => _ListaFilmesState();
}

class _ListaFilmesState extends State<ListaFilmes> {
  
  List<Map<String, dynamic>> filmes = [
    {
      'id': 1,
      'urlImagem': 'https://via.placeholder.com/150',
      'titulo': 'Filme Exemplo 1',
      'genero': 'Ação',
      'pontuacao': 4.5,
    },
    {
      'id': 2,
      'urlImagem': 'https://via.placeholder.com/150',
      'titulo': 'Filme Exemplo 2',
      'genero': 'Comédia',
      'pontuacao': 3.0,
    },
  ];

  
  void _carregarFilmes() {
    setState(() {
      
    });
  }

  void deletarFilme(int id) {
    setState(() {
      filmes.removeWhere((filme) => filme['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Filmes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Nome do Grupo'),
                  content: const Text('Grupo 1 - Gerenciador de Filmes'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filmes.length,
        itemBuilder: (context, index) {
          final filme = filmes[index];
          return Dismissible(
            key: Key(filme['id'].toString()),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              deletarFilme(filme['id']);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${filme['titulo']} foi deletado.')),
              );
            },
            background: Container(
              color: Colors.red,
              padding: const EdgeInsets.only(left: 16.0),
              alignment: Alignment.centerLeft,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              leading: Image.network(
                filme['urlImagem'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(filme['titulo']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(filme['genero']),
                  RatingBarIndicator(
                    rating: filme['pontuacao'],
                    itemBuilder: (context, index) =>
                        const Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 20.0,
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cadastro').then((_) => _carregarFilmes());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
