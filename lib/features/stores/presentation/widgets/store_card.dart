import 'package:flutter/material.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/stores/domain/entities/entities.dart';

class StoreCard extends StatelessWidget {
  final MarketerStore store;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onViewBanners;
  final VoidCallback? onViewProducts;

  const StoreCard({
    super.key,
    required this.store,
    this.onEdit,
    this.onDelete,
    this.onViewBanners,
    this.onViewProducts,
  });

  @override
  Widget build(BuildContext context) {
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
                const Icon(
                  Icons.storefront,
                  color: Colors.blueAccent,
                  size: 32,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    store.nombre,
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
                    // final link = 'https://tusitio.com/stores/${store.slug}';
                    // Share.share('Visita la tienda ${store.nombre}: $link');
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),

            Text(
              store.descripcion.isNotEmpty
                  ? store.descripcion
                  : 'Sin descripción',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: 12,
              runSpacing: 4,
              children: [
                _InfoChip(icon: Icons.store, label: 'Código: ${store.codigo}'),
                _InfoChip(icon: Icons.flag, label: 'País: ${store.pais}'),
                _InfoChip(
                  icon: Icons.attach_money,
                  label: 'Moneda: ${store.moneda}',
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ActionButton(
                  icon: Icons.edit,
                  label: 'Editar',
                  onTap: onEdit,
                  color: Colors.blueAccent,
                ),
                _ActionButton(
                  icon: Icons.delete_outline,
                  label: 'Borrar',
                  onTap: onDelete,
                  color: Colors.redAccent,
                ),
                _ActionButton(
                  icon: Icons.image_outlined,
                  label: 'Banners',
                  onTap: onViewBanners,
                  color: Colors.orangeAccent,
                ),
                _ActionButton(
                  icon: Icons.shopping_bag_outlined,
                  label: 'Productos',
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
