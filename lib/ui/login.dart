import 'package:flutter/material.dart';

import '../root/pallet.dart';
import 'botao.dart';
import 'campo.dart';
import 'card.dart';
import 'logo.dart';
import 'cadastro.dart';
import 'home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: CardPadrao(
                child: Column(
                  children: [
                    const Logo(),

                    const SizedBox(height: 30),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Login da Conta',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppPalette.texto,
                        ),
                      ),
                    ),

                    const SizedBox(height: 7),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Entre para continuar sua jornada financeira.',
                        style: TextStyle(
                          color: AppPalette.cinza,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Campo(
                      titulo: 'E-mail',
                      hint: 'seu@email.com',
                    ),

                    const SizedBox(height: 16),

                    const Campo(
                      titulo: 'Senha',
                      hint: 'Digite sua senha',
                      senha: true,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Esqueceu a senha?',
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Botao(
                      texto: 'Entrar',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomePage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    Botao(
                      texto: 'Criar conta',
                      contorno: true,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CadastroPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'ou continue com',
                      style: TextStyle(
                        color: AppPalette.cinza,
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.g_mobiledata,
                        ),
                        label: const Text(
                          'Continuar com Google',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}