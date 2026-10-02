import 'package:flutter/material.dart';

import 'botao.dart';
import 'card.dart';
import 'login.dart';
import 'planos.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Meu Perfil',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        const CardPadrao(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Sanyuri Kat',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 5),

              Text(
                'sanyuri@email.com',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 18),

              _LinhaPerfil(
                'Cursos concluídos',
                '4',
              ),

              _LinhaPerfil(
                'Quiz realizados',
                '6',
              ),

              _LinhaPerfil(
                'Investimentos',
                'R\$ 24.315,30',
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),

        Botao(
          texto: 'Planos',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PlanosPage(),
              ),
            );
          },
        ),

        const SizedBox(height: 10),

        Botao(
          texto: 'Sair',
          contorno: true,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginPage(),
              ),
              (_) => false,
            );
          },
        ),
      ],
    );
  }
}

class _LinhaPerfil extends StatelessWidget {
  final String titulo;
  final String valor;

  const _LinhaPerfil(
    this.titulo,
    this.valor,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 7,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(titulo),
          ),

          Text(
            valor,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}