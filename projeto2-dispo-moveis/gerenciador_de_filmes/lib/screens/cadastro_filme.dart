import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/filme.dart';

class CadastroFilme extends StatefulWidget {
  @override
  _CadastroFilmeState createState() => _CadastroFilmeState();
}

class _CadastroFilmeState extends State<CadastroFilme> {
  final _formKey = GlobalKey<FormState>();
  final _urlImagemController = TextEditingController();
  final _tituloController = TextEditingController();
  final _generoController = TextEditingController();
  final _faixaEtariaController = TextEditingController();
  final _duracaoController = TextEditingController();
  final _pontuacaoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _anoController = TextEditingController();

  void _salvarFilme() async {
    if (_formKey.currentState!.validate()) {
      final novoFilme = Filme(
        urlImagem: _urlImagemController.text,
        titulo: _tituloController.text,
        genero: _generoController.text,
        faixaEtaria: _faixaEtariaController.text,
        duracao: int.parse(_duracaoController.text),
        pontuacao: double.parse(_pontuacaoController.text),
        descricao: _descricaoController.text,
        ano: int.parse(_anoController.text),
      );

      await DBHelper().inserirFilme(novoFilme);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Filme cadastrado com sucesso!')),
      );

      Navigator.pop(context); // Voltar para a tela anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Filme')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _urlImagemController,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe uma URL válida.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O título é obrigatório.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _generoController,
                decoration: InputDecoration(labelText: 'Gênero'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O gênero é obrigatório.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _faixaEtariaController,
                decoration: InputDecoration(labelText: 'Faixa Etária'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A faixa etária é obrigatória.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _duracaoController,
                decoration: InputDecoration(labelText: 'Duração (em minutos)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Informe uma duração válida.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pontuacaoController,
                decoration: InputDecoration(labelText: 'Pontuação (0-10)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'Informe uma pontuação válida.';
                  }
                  final pontuacao = double.parse(value);
                  if (pontuacao < 0 || pontuacao > 10) {
                    return 'A pontuação deve estar entre 0 e 10.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
              ),
              TextFormField(
                controller: _anoController,
                decoration: InputDecoration(labelText: 'Ano'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Informe um ano válido.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarFilme,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
