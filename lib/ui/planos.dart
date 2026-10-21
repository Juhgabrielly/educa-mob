
import 'package:flutter/material.dart';
import '../data/app_repository.dart';
import '../data/app_repository_scope.dart';
import '../root/pallet.dart';
import '../ui/card.dart';
import '../ui/botao.dart';

class PlanosPage extends StatelessWidget {
  const PlanosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Planos e assinatura')),
      body: FutureBuilder<List<SubscriptionPlan>>(
        future: AppRepositoryScope.of(context).getSubscriptionPlans(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Não foi possível carregar os planos.'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final plans = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(18),
            children: [
              const Text(
                'Escolha seu plano',
                style: TextStyle(
                  color: AppPalette.roxoEscuro,
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Evolua no seu ritmo com nossos planos.',
                style: TextStyle(color: AppPalette.textoSecundario),
              ),
              const SizedBox(height: 22),
              if (plans.isEmpty)
                const Text('Nenhum plano disponível no momento.')
              else
                ...plans.map(
                  (plan) => Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: _Plano(plan: plan),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Plano extends StatefulWidget {
  final SubscriptionPlan plan;

  const _Plano({required this.plan});

  @override
  State<_Plano> createState() => _PlanoState();
}

class _PlanoState extends State<_Plano> {
  bool _enviando = false;

  Future<void> _selecionarPlano() async {
    setState(() => _enviando = true);
    try {
      await AppRepositoryScope.of(context)
          .selectSubscriptionPlan(widget.plan.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.plan.name} selecionado.')),
      );
    } on Exception catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível selecionar o plano: $error')),
      );
    } finally {
      if (mounted) setState(() => _enviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CardPadrao(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.plan.name,
            style: const TextStyle(
              color: AppPalette.roxoEscuro,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.plan.price,
            style: const TextStyle(
              color: AppPalette.roxo,
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 15),
          ...widget.plan.features.map(
            (recurso) => Padding(
              padding: const EdgeInsets.only(bottom: 11),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppPalette.verde,
                    size: 19,
                  ),
                  const SizedBox(width: 9),
                  Expanded(child: Text(recurso)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          BotaoContorno(
            texto: _enviando ? 'Processando...' : 'Selecionar plano',
            onPressed: _enviando ? null : _selecionarPlano,
          ),
        ],
      ),
    );
  }
}