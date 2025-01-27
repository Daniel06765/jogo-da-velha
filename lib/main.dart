import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JogoDaVelha(),
    );
  }
}

class JogoDaVelha extends StatefulWidget {
  @override
  _JogoDaVelhaState createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  List<String> _tabuleiro = List.generate(9, (index) => "");
  String _jogadorAtual = "X";
  String _vencedor = "";

  // Função para fazer uma jogada
  void _jogar(int index) {
    if (_tabuleiro[index] == "" && _vencedor == "") {
      setState(() {
        _tabuleiro[index] = _jogadorAtual;
        _verificarVencedor();
        if (_vencedor == "") {
          _jogadorAtual = _jogadorAtual == "X" ? "O" : "X";
        }
      });
    }
  }

  // Função para verificar o vencedor
  void _verificarVencedor() {
    List<List<int>> combinacoes = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],  // Linhas
      [0, 3, 6], [1, 4, 7], [2, 5, 8],  // Colunas
      [0, 4, 8], [2, 4, 6]              // Diagonais
    ];

    for (var combinacao in combinacoes) {
      if (_tabuleiro[combinacao[0]] != "" &&
          _tabuleiro[combinacao[0]] == _tabuleiro[combinacao[1]] &&
          _tabuleiro[combinacao[1]] == _tabuleiro[combinacao[2]]) {
        setState(() {
          _vencedor = _tabuleiro[combinacao[0]];
        });
      }
    }
  }

  // Função para reiniciar o jogo
  void _reiniciarJogo() {
    setState(() {
      _tabuleiro = List.generate(9, (index) => "");
      _vencedor = "";
      _jogadorAtual = "X";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogo da Velha"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            _vencedor == "" ? "Jogador $_jogadorAtual" : "Vencedor: $_vencedor",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 20),
          _buildTabuleiro(),
          SizedBox(height: 20),
          _buildBotaoReiniciar(),  // O botão para reiniciar o jogo
        ],
      ),
    );
  }

  // Função para desenhar o tabuleiro
  Widget _buildTabuleiro() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
      ),
      itemCount: 9,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _jogar(index),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                _tabuleiro[index],
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
        );
      },
    );
  }

  // Função para o botão de reiniciar
  Widget _buildBotaoReiniciar() {
    return ElevatedButton(
      onPressed: _reiniciarJogo,  // Chama a função de reiniciar
      child: Text('Reiniciar Jogo'),
    );
  }
}
