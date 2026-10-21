import 'package:flutter/material.dart';
import '../data/app_repository.dart';
import '../data/app_repository_scope.dart';
import '../root/pallet.dart';
import '../ui/card.dart';

class MetasPage extends StatelessWidget {
  const MetasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Metas financeiras')),
      body: FutureBuilder<List<FinancialGoal>>(
        future: AppRepositoryScope.of(context).getFinancialGoals(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Não foi possível carregar suas metas.'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final goals = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(18),
            children: [
              const Text(
                'Seus objetivos',
                style: TextStyle(
                  color: AppPalette.roxoEscuro,
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Pequenos passos para grandes conquistas.',
                style: TextStyle(color: AppPalette.textoSecundario),
              ),
              const SizedBox(height: 22),
              if (goals.isEmpty)
                const Text('Você ainda não cadastrou metas.')
              else
                ...goals.map(
                  (goal) => Padding(
                    padding: const EdgeInsets.only(bottom: 13),
                    child: _Meta(goal: goal),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  final FinancialGoal goal;

  const _Meta({required this.goal});

  @override
  Widget build(BuildContext context) {
    return CardPadrao(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            goal.title,
            style: const TextStyle(
              color: AppPalette.roxoEscuro,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          LinearProgressIndicator(
            value: goal.progress,
            minHeight: 8,
            borderRadius: BorderRadius.circular(20),
            color: AppPalette.roxo,
            backgroundColor: AppPalette.borda,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Guardado: ${_formatCurrency(goal.saved)}',
                  style: const TextStyle(fontSize: 11),
                ),
              ),
              Text(
                '${(goal.progress * 100).round()}%',
                style: const TextStyle(
                  color: AppPalette.roxo,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Objetivo: ${_formatCurrency(goal.target)}',
            style: const TextStyle(
              color: AppPalette.textoSecundario,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) =>
      'R\$ ${amount.toStringAsFixed(2).replaceAll('.', ',')}';
}
