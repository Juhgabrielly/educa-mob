
import 'package:flutter/material.dart';
import '../root/pallet.dart';

class CardPadrao extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const CardPadrao({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppPalette.superficie,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppPalette.borda),
        boxShadow: [
          BoxShadow(
            color: AppPalette.roxo.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}