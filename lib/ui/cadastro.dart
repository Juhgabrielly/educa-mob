
import 'package:flutter/material.dart';
import '../ui/campo.dart';
import '../ui/botao.dart';
import '../ui/card.dart';
import '../data/app_repository_scope.dart';
import '../root/pallet.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  final confirmar = TextEditingController();
  bool _enviando = false;

  @override
  void dispose() {
    nome.dispose();
    email.dispose();
    senha.dispose();
    confirmar.dispose();
    super.dispose();
  }

  Future<void> cadastrar() async {
    if ([nome.text, email.text, senha.text, confirmar.text]
        .any((v) => v.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos.')),
      );
      return;
    }

    if (senha.text != confirmar.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As senhas não coincidem.')),
      );
      return;
    }

    setState(() => _enviando = true);
    try {
      await AppRepositoryScope.of(context).register(
        name: nome.text.trim(),
        email: email.text.trim(),
        password: senha.text,
      );
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conta criada com sucesso.')),
      );
    } on Exception catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível criar a conta: $error')),
      );
    } finally {
      if (mounted) setState(() => _enviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Comece sua jornada financeira!',
            style: TextStyle(
              color: AppPalette.roxoEscuro,
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Preencha os dados para criar sua conta.',
            style: TextStyle(color: AppPalette.textoSecundario),
          ),
          const SizedBox(height: 22),
          CardPadrao(
            child: Column(
              children: [
                Campo(
                  titulo: 'Nome completo',
                  dica: 'Digite seu nome',
                  controller: nome,
                ),
                const SizedBox(height: 15),
                Campo(
                  titulo: 'E-mail',
                  dica: 'seu@email.com',
                  controller: email,
                  teclado: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                Campo(
                  titulo: 'Senha',
                  dica: 'Crie uma senha',
                  controller: senha,
                  senha: true,
                ),
                const SizedBox(height: 15),
                Campo(
                  titulo: 'Confirmar senha',
                  dica: 'Digite a senha novamente',
                  controller: confirmar,
                  senha: true,
                ),
                const SizedBox(height: 22),
                Botao(
                  texto: _enviando ? 'Criando conta...' : 'Criar conta',
                  onPressed: _enviando ? null : cadastrar,
                ),
                const SizedBox(height: 10),
                BotaoContorno(
                  texto: 'Voltar para o login',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}