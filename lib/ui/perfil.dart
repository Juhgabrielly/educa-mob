import 'package:flutter/material.dart';
import '../data/app_repository.dart';
import '../data/app_repository_scope.dart';
import '../root/pallet.dart';
import '../ui/card.dart';
import 'metas.dart';
import 'planos.dart';
import 'login.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppUser?>(
      future: AppRepositoryScope.of(context).getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Não foi possível carregar seu perfil.'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final user = snapshot.data;
        if (user == null) {
          return const Center(child: Text('Nenhum usuário conectado.'));
        }

        return ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text(
              'Meu Perfil',
              style: TextStyle(
                color: AppPalette.roxoEscuro,
                fontSize: 27,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Gerencie suas informações e preferências.',
              style: TextStyle(color: AppPalette.textoSecundario),
            ),
            const SizedBox(height: 20),
            CardPadrao(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 42,
                    backgroundColor: AppPalette.roxo,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.name,
                    style: const TextStyle(
                      color: AppPalette.roxoEscuro,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.email,
                    style: const TextStyle(color: AppPalette.textoSecundario),
                  ),
                  const Divider(height: 28, color: AppPalette.borda),
                  _Opcao(
                    icone: Icons.person_outline,
                    titulo: 'Dados pessoais',
                    acao: () =>
                        _aviso(context, 'Edite seus dados em breve.'),
                  ),
                  _Opcao(
                    icone: Icons.notifications_none,
                    titulo: 'Notificações',
                    acao: () =>
                        _aviso(context, 'Configurações de notificações.'),
                  ),
                  _Opcao(
                    icone: Icons.workspace_premium_outlined,
                    titulo: 'Planos e assinatura',
                    acao: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PlanosPage(),
                      ),
                    ),
                  ),
                  _Opcao(
                    icone: Icons.flag_outlined,
                    titulo: 'Metas financeiras',
                    acao: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MetasPage(),
                      ),
                    ),
                  ),
                  _Opcao(
                    icone: Icons.logout,
                    titulo: 'Sair da conta',
                    cor: AppPalette.vermelho,
                    acao: () => _sair(context),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _sair(BuildContext context) async {
    try {
      await AppRepositoryScope.of(context).signOut();
      if (!context.mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (rota) => false,
      );
    } on Exception catch (error) {
      if (!context.mounted) return;
      _aviso(context, 'Não foi possível sair da conta: $error');
    }
  }

  static void _aviso(
    BuildContext context,
    String texto,
  ) {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        content: Text(texto),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppPalette.roxoEscuro,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class _Opcao extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final VoidCallback acao;
  final Color cor;

  const _Opcao({
    required this.icone,
    required this.titulo,
    required this.acao,
    this.cor = AppPalette.roxo,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        ),
        onTap: acao,
        leading: Icon(
          icone,
          color: cor,
        ),
        title: Text(
          titulo,
          style: TextStyle(
            color: cor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppPalette.textoSecundario,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        splashColor: AppPalette.roxo.withValues(alpha: 0.10),
        hoverColor: AppPalette.roxo.withValues(alpha: 0.05),
      ),
    );
  }
}