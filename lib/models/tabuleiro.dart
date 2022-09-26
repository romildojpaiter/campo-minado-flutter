import 'dart:math';

import 'campo.dart';

class Tabuleiro {
  //
  final int linhas;
  final int colunas;
  final int qtdeBombas;

  final List<Campo> _campos = [];

  Tabuleiro({
    required this.linhas,
    required this.colunas,
    required this.qtdeBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }

  void reinicar() {
    for (var element in _campos) {
      element.reiniciar();
    }
    _sortearMinas();
  }

  void revelarBombas() {
    for (var element in _campos) {
      element.revelarBomba();
    }
  }

  void _criarCampos() {
    for (var l = 0; l < linhas; l++) {
      for (var c = 0; c < colunas; c++) {
        _campos.add(Campo(linha: l, coluna: c));
      }
    }
  }

  void _relacionarVizinhos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionaVizinho(vizinho);
      }
    }
  }

  void _sortearMinas() {
    int sorteadas = 0;

    if (qtdeBombas > (linhas * colunas)) {
      return;
    }

    while (sorteadas < qtdeBombas) {
      int i = Random().nextInt(_campos.length);
      if (campoNaoMinado(i)) {
        sorteadas++;
        _campos[i].minar();
      }
    }
  }

  bool campoNaoMinado(int index) => !_campos[index].minado;

  List<Campo> get campos {
    return _campos;
  }

  bool get resolvido {
    return _campos.every((element) => element.resolvido);
  }
}
