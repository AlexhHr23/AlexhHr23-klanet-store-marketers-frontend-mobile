import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/packages/domain/domain.dart';
import 'package:klanetmarketers/features/shared/providers/currency_provider.dart';
import 'package:share_plus/share_plus.dart';

class CardPackage extends ConsumerWidget {
  final Package package;
  final VoidCallback? onDelete;
  final VoidCallback? onAddProducts;
  final VoidCallback? onViewProducts;

  const CardPackage({
    super.key,
    required this.package,
    this.onDelete,
    this.onAddProducts,
    this.onViewProducts,
  });

  void _showCurrencySelection(BuildContext context, WidgetRef ref) {
    final currenciesState = ref.watch(currencyProvider).currencies;

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            ...currenciesState.map(
              (currency) => ListTile(
                leading: const Icon(
                  Icons.currency_exchange,
                  color: AppColors.primary,
                ),
                title: Text(currency.name),
                onTap: () {
                  Navigator.pop(context);
                  _shareLink(context, currency.code.toString());
                },
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }

  void _shareLink(BuildContext context, String currencyId) async {
    final shareUri = Uri.parse(
      // '$link/products/${product.padre.id}/${product.slug}?code=${authState.user?.profile.sellerCode}&moneda=$currencyId&product=${product.id}',
      '',
    );
    final params = ShareParams(uri: shareUri);
    await SharePlus.instance.share(params);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const Icon(
                //   Icons.storefront,
                //   color: Colors.blueAccent,
                //   size: 32,
                // ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    package.nombre,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.grey),
                  onPressed: () {
                    _showCurrencySelection(context, ref);
                  },
                ),
              ],
            ),
            Wrap(
              spacing: 12,
              runSpacing: 4,
              children: [
                _InfoChip(
                  icon: Icons.location_on,
                  label: 'Pais: ${package.pais}',
                ),
                _InfoChip(
                  icon: Icons.category_outlined,
                  label: 'TIpo: ${package.tipo == '1' ? 'Fisico' : 'Digital'}',
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ActionButton(
                  icon: Icons.add,
                  label: 'Agregar productos',
                  onTap: onAddProducts,
                  color: Colors.blueAccent,
                ),
                _ActionButton(
                  icon: Icons.delete_outline,
                  label: 'Eliminar',
                  onTap: onDelete,
                  color: Colors.redAccent,
                ),
                _ActionButton(
                  icon: Icons.shopping_bag_outlined,
                  label: 'Ver productos',
                  onTap: onViewProducts,
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      backgroundColor: AppColors.tertiary,
      padding: const EdgeInsets.symmetric(horizontal: 6),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
