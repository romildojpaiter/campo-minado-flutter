import 'dart:math';

import 'package:campo_minado/models/explosao_exception.dart';
import 'package:flutter/foundation.dart';

class Campo {
  final int linha;
  final int coluna;
  final List<Campo> vizinhos = List.empty(growable: true);

  bool _aberto = false;
  bool _marcado = false;
  bool _minado = false;
  bool _explodido = false;

  Campo({
    required this.linha,
    required this.coluna,
  });

  void adicionaVizinho(Campo vizinho) {
    final deltaLinha = (linha - vizinho.linha).abs();
    final deltaColuna = (coluna - vizinho.coluna).abs();

    if (deltaColuna == 0 && deltaColuna == 0) {
      return;
    }

    if (deltaLinha <= 1 && deltaColuna <= 1) {
      vizinhos.add(vizinho);
    }
  }

  void abrir() {
    if (_aberto) return;

    _aberto = true;

    if (_minado) {
      _explodido = true;
      throw ExplosaoException();
    }

    if (vizinhancaSegura) {
      vizinhos.forEach((element) => element.abrir());
    }
  }

  void revelarBombas() {
    if (_minado) {
      _aberto = false;
    }
  }

  void minar() {
    _minado = true;
  }

  void alternarMarcacao() {
    _marcado = !_marcado;
  }

  void reiniciar() {
    _aberto = false;
    _marcado = false;
    _minado = false;
    _explodido = false;
  }

  bool get vizinhancaSegura {
    return vizinhos.every((element) => !element._minado);
  }

  bool get minado {
    return _minado;
  }

  bool get aberto {
    return _aberto;
  }

  bool get marcado {
    return _marcado;
  }

  bool get resolvido {
    bool minadoEMarcado = minado && marcado;
    bool seguroEAberto = !minado && aberto;
    return minadoEMarcado || seguroEAberto;
  }

  int get qtdeMinasVizinhanca {
    return vizinhos.where((element) => element.minado).length;
  }
}
