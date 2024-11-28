import 'package:flutter/material.dart';
import 'screens/lista_filmes.dart';
import 'screens/cadastro_filme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Filmes',
      initialRoute: '/',
      routes: {
        '/': (context) => ListaFilmes(),
        '/cadastro': (context) => CadastroFilme(),
      },
    );
  }
}
