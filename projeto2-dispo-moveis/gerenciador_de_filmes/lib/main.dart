import 'package:flutter/material.dart';
import 'screens/lista_filmes.dart';
import 'screens/cadastro_filme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Adiciona suporte para chave no widget.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Filmes',
      debugShowCheckedModeBanner: false, // Remove o banner "DEBUG".
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define um tema padrão para o app.
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ListaFilmes(),
        '/cadastro': (context) => CadastroFilme(),
      },
    );
  }
}
