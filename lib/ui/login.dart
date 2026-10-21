
import 'package:flutter/material.dart';
import '../data/app_repository_scope.dart';
import '../root/pallet.dart';
import '../ui/logo.dart';
import '../ui/campo.dart';
import '../ui/botao.dart';
import '../ui/card.dart';
import 'home.dart';
import 'cadastro.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final senha = TextEditingController();
  bool _enviando = false;

  @override
  void dispose() {
    email.dispose();
    senha.dispose();
    super.dispose();
  }

  Future<void> entrar() async {
    if (email.text.trim().isEmpty || senha.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha seu e-mail e senha.')),
      );
      return;
    }

    setState(() => _enviando = true);
    try {
      await AppRepositoryScope.of(context).signIn(
        email: email.text.trim(),
        password: senha.text,
      );
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } on Exception catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível entrar: $error')),
      );
    } finally {
      if (mounted) setState(() => _enviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8F4FF),
              Color(0xFFE8D9FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(22),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  children: [
                    const Logo(tamanho: 52),
                    const SizedBox(height: 28),
                    CardPadrao(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Login da Conta',
                              style: TextStyle(
                                color: AppPalette.roxoEscuro,
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Center(
                            child: Text(
                              'Entre para continuar sua jornada financeira.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppPalette.textoSecundario,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Center(
                            child: Text(
                              'Modo demonstração: as credenciais ainda não são '
                              'validadas por um servidor.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppPalette.textoSecundario,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Campo(
                            titulo: 'E-mail',
                            dica: 'seu@email.com',
                            controller: email,
                            teclado: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 17),
                          Campo(
                            titulo: 'Senha',
                            dica: 'Digite sua senha',
                            controller: senha,
                            senha: true,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Recuperação de senha em breve.',
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Esqueceu a senha?'),
                            ),
                          ),
                          Botao(
                            texto: _enviando ? 'Entrando...' : 'Entrar',
                            onPressed: _enviando ? null : entrar,
                          ),
                          const SizedBox(height: 12),
                          BotaoContorno(
                            texto: 'Criar conta',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CadastroPage(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          BotaoContorno(
                            texto: 'Continuar com Google',
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'O login Google precisa ser integrado.',
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Aprenda. Organize. Evolua.',
                      style: TextStyle(
                        color: AppPalette.roxoEscuro,
                        fontWeight: FontWeight.w600,
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