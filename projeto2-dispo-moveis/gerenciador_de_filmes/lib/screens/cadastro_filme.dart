import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class CadastroFilme extends StatefulWidget {
  @override
  _CadastroFilmeState createState() => _CadastroFilmeState();
}

class _CadastroFilmeState extends State<CadastroFilme> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _tituloController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();

  String? _faixaEtaria;
  double _pontuacao = 0;

  
  final List<String> _faixasEtarias = ['Livre', '10', '12', '14', '16', '18'];

  
  void _salvarFilme() {
    if (_formKey.currentState!.validate()) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Filme cadastrado com sucesso!')),
      );

      
      _tituloController.clear();
      _descricaoController.clear();
      setState(() {
        _faixaEtaria = null;
        _pontuacao = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Filme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                TextFormField(
                  controller: _tituloController,
                  decoration: InputDecoration(labelText: 'Título do Filme'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O título é obrigatório';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: _faixaEtaria,
                  decoration: InputDecoration(labelText: 'Faixa Etária'),
                  items: _faixasEtarias.map((faixa) {
                    return DropdownMenuItem<String>(
                      value: faixa,
                      child: Text(faixa),
                    );
                  }).toList(),
                  onChanged: (valorSelecionado) {
                    setState(() {
                      _faixaEtaria = valorSelecionado;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Selecione uma faixa etária';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                
                TextFormField(
                  controller: _descricaoController,
                  decoration: InputDecoration(labelText: 'Descrição'),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A descrição é obrigatória';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                
                Text('Pontuação do Filme:'),
                SmoothStarRating(
                  allowHalfRating: true,
                  onRatingChanged: (valor) {
                    setState(() {
                      _pontuacao = valor;
                    });
                  },
                  starCount: 5,
                  rating: _pontuacao,
                  size: 40.0,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  color: Colors.amber,
                  borderColor: Colors.amber,
                  spacing: 2.0,
                ),
                SizedBox(height: 16),

                Center(
                  child: ElevatedButton(
                    onPressed: _salvarFilme,
                    child: Text('Salvar Filme'),
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
