
import 'package:flutter/material.dart';
import '../data/app_repository.dart';
import '../data/app_repository_scope.dart';
import '../root/pallet.dart';
import '../ui/card.dart';

class InvestimentosPage extends StatelessWidget {
  const InvestimentosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<InvestmentPortfolio>(
      future: AppRepositoryScope.of(context).getInvestmentPortfolio(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Não foi possível carregar seus investimentos.'),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return _buildContent(snapshot.data!);
      },
    );
  }

  Widget _buildContent(InvestmentPortfolio portfolio) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Seus Investimentos',
          style: TextStyle(
            color: AppPalette.roxoEscuro,
            fontSize: 27,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Acompanhe sua carteira e aprenda a investir.',
          style: TextStyle(color: AppPalette.textoSecundario),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _Indicador(
                titulo: 'Patrimônio',
                valor: _formatCurrency(portfolio.total),
                icone: Icons.account_balance_wallet_outlined,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _Indicador(
                titulo: 'Rentabilidade',
                valor: '${portfolio.returnPercentage.toStringAsFixed(1)}%',
                icone: Icons.trending_up,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Minha carteira',
          style: TextStyle(
            color: AppPalette.roxoEscuro,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 13),
        CardPadrao(
          child: Column(
            children: portfolio.holdings.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(item.name)),
                        Text(
                          '${item.percentage.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: AppPalette.roxo,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: item.percentage / 100,
                        minHeight: 8,
                        color: AppPalette.roxoClaro,
                        backgroundColor: AppPalette.borda,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Aprenda sobre investimentos',
          style: TextStyle(
            color: AppPalette.roxoEscuro,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        const _Info(
          titulo: 'Renda fixa',
          descricao: 'Conheça títulos e formas de remuneração.',
          icone: Icons.savings_outlined,
        ),
        const SizedBox(height: 10),
        const _Info(
          titulo: 'Renda variável',
          descricao: 'Entenda riscos e oportunidades do mercado.',
          icone: Icons.show_chart,
        ),
      ],
    );
  }

  String _formatCurrency(double amount) =>
      'R\$ ${amount.toStringAsFixed(2).replaceAll('.', ',')}';
}

class _Indicador extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icone;

  const _Indicador({
    required this.titulo,
    required this.valor,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return CardPadrao(
      padding: const EdgeInsets.all(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icone, color: AppPalette.roxo),
          const SizedBox(height: 12),
          Text(
            titulo,
            style: const TextStyle(
              color: AppPalette.textoSecundario,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 5),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              valor,
              style: const TextStyle(
                color: AppPalette.roxoEscuro,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final String titulo;
  final String descricao;
  final IconData icone;

  const _Info({
    required this.titulo,
    required this.descricao,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return CardPadrao(
      child: Row(
        children: [
          Icon(icone, size: 30, color: AppPalette.roxo),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    color: AppPalette.roxoEscuro,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  descricao,
                  style: const TextStyle(
                    color: AppPalette.textoSecundario,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}