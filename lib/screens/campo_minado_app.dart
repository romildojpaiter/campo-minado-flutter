import 'package:campo_minado/components/campo_widget.dart';
import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/models/campo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CampoMinadoApp extends StatelessWidget {
  //

  _reinicar() {
    print('Estou sendo reiniciado');
  }

  @override
  Widget build(BuildContext context) {
    Campo campo = Campo(linha: 0, coluna: 0);
    campo.abrir();

    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(venceu: null, onReiniciar: _reinicar()),
        body: Container(
          child: CampoWidget(
              campo: campo,
              onAbrir: _abrir,
              onAlternarMarcacao: _alternarMarcacao),
        ),
      ),
    );
  }

  void _abrir(Campo campo) {
    print('abrir...');
  }

  void _alternarMarcacao(Campo campo) {
    print('alternar marcaca...');
  }
}
