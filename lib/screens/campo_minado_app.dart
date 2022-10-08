import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/models/campo.dart';
import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

class CampoMinadoApp extends StatefulWidget {
  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  //
  // Tabuleiro _tabuleiro = Tabuleiro(linhas: 12, colunas: 12, qtdeBombas: 3);
  Tabuleiro? _tabuleiro;
  bool? _venceu;

  _reinicar() {
    setState(() {
      _venceu = null;
      _tabuleiro!.reinicar();
    });
  }

  void _abrir(Campo campo) {
    if (_venceu != null) {
      return;
    }
    setState(() {
      try {
        campo.abrir();
        if (_tabuleiro!.resolvido) {
          _venceu = true;
        }
      } on ExplosaoException {
        _venceu = false;
        _tabuleiro!.revelarBombas();
      }
    });
  }

  void _alternarMarcacao(Campo campo) {
    if (_venceu != null) {
      return;
    }
    setState(() {
      campo.alternarMarcacao();
      if (_tabuleiro!.resolvido) {
        _venceu = true;
      }
    });
  }

  Tabuleiro _getTabuleiro(double largura, double altura) {
    if (_tabuleiro == null) {
      int qtdeColunas = 15;
      double tamanhoCampo = largura / qtdeColunas;
      int qtdLinhas = (altura / tamanhoCampo).floor();
      _tabuleiro = Tabuleiro(
        linhas: qtdLinhas,
        colunas: qtdeColunas,
        qtdeBombas: 50,
      );
    }
    return _tabuleiro!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReiniciar: _reinicar,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return TabuleiroWidget(
                tabuleiro: _getTabuleiro(
                  constraints.maxWidth,
                  constraints.maxHeight,
                ),
                onAbrir: _abrir,
                onAlternarMarcacao: _alternarMarcacao,
              );
            },
          ),
        ),
      ),
    );
  }
}
