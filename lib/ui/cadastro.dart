import 'package:flutter/material.dart';

import 'botao.dart';
import 'campo.dart';
import 'card.dart';
import 'logo.dart';
import 'home.dart';

class CadastroPage extends StatelessWidget {
  const CadastroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Logo(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: CardPadrao(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cadastro da Conta',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 22),
              const Campo(
                titulo: 'Nome',
                hint: 'Digite seu nome',
              ),
              const SizedBox(height: 15),
              const Campo(
                titulo: 'E-mail',
                hint: 'seu@email.com',
              ),
              const SizedBox(height: 15),
              const Campo(
                titulo: 'Senha',
                hint: 'Digite sua senha',
                senha: true,
              ),
              const SizedBox(height: 22),
              Botao(
                texto: 'Criar conta',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomePage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
