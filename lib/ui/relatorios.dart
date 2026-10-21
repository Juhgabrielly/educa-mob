
import 'package:flutter/material.dart';

import '../data/app_repository.dart';
import '../data/app_repository_scope.dart';
import '../root/pallet.dart';
import '../ui/card.dart';

class RelatoriosPage extends StatelessWidget {
  const RelatoriosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FinancialReport>(
      future: AppRepositoryScope.of(context).getFinancialReport(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Não foi possível carregar o relatório financeiro.'),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final report = snapshot.data!;

        return MediaQuery.withClampedTextScaling(
          minScaleFactor: 1.0,
          maxScaleFactor: 1.15,
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              const Text(
                'Resultados Financeiros',
                style: TextStyle(
                  color: AppPalette.roxoEscuro,
                  fontSize: 25,
                  height: 1.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Veja um resumo da sua evolução financeira.',
                style: TextStyle(
                  color: AppPalette.textoSecundario,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _Resumo(
                      titulo: 'Receitas',
                      valor: _formatCurrency(report.income),
                      cor: AppPalette.verde,
                      icone: Icons.south_west,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _Resumo(
                      titulo: 'Despesas',
                      valor: _formatCurrency(report.expenses),
                      cor: AppPalette.vermelho,
                      icone: Icons.north_east,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _Resumo(
                titulo: 'Saldo do período',
                valor: _formatCurrency(report.balance),
                cor: AppPalette.roxo,
                icone: Icons.account_balance,
              ),
              const SizedBox(height: 25),
              const Text(
                'Histórico financeiro',
                style: TextStyle(
                  color: AppPalette.roxoEscuro,
                  fontSize: 19,
                  height: 1.3,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              CardPadrao(
                child: Column(
                  children: report.transactions.isEmpty
                      ? const [
                          Text('Nenhuma transação neste período.'),
                        ]
                      : [
                          for (var index = 0;
                              index < report.transactions.length;
                              index++) ...[
                            _Transacao(
                              nome: report.transactions[index].name,
                              categoria:
                                  '${report.transactions[index].category} • '
                                  '${_formatDate(report.transactions[index].date)}',
                              valor:
                                  '${report.transactions[index].isIncome ? '+' : '-'} '
                                  '${_formatCurrency(report.transactions[index].amount.abs())}',
                              positiva: report.transactions[index].isIncome,
                            ),
                            if (index < report.transactions.length - 1)
                              const Divider(
                                color: AppPalette.borda,
                                height: 25,
                              ),
                          ],
                        ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static String _formatCurrency(double amount) =>
      'R\$ ${amount.toStringAsFixed(2).replaceAll('.', ',')}';

  static String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/${date.year}';
}

class _Resumo extends StatelessWidget {
  final String titulo;
  final String valor;
  final Color cor;
  final IconData icone;

  const _Resumo({
    required this.titulo,
    required this.valor,
    required this.cor,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return CardPadrao(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icone,
            color: cor,
            size: 24,
          ),

          const SizedBox(height: 10),

          Text(
            titulo,
            style: const TextStyle(
              color: AppPalette.textoSecundario,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 6),

          SizedBox(
            width: double.infinity,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: Text(
                valor,
                style: TextStyle(
                  color: cor,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Transacao extends StatelessWidget {
  final String nome;
  final String categoria;
  final String valor;
  final bool positiva;

  const _Transacao({
    required this.nome,
    required this.categoria,
    required this.valor,
    required this.positiva,
  });

  @override
  Widget build(BuildContext context) {
    final cor = positiva
        ? AppPalette.verde
        : AppPalette.vermelho;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          positiva
              ? Icons.south_west
              : Icons.north_east,
          color: cor,
          size: 21,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nome,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppPalette.roxoEscuro,
                  fontSize: 16,
                  height: 1.3,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                categoria,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppPalette.textoSecundario,
                  fontSize: 11,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              valor,
              style: TextStyle(
                color: cor,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
