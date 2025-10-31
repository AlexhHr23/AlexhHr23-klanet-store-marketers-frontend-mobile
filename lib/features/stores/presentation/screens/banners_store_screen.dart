import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/shared/layout/app_layout.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/store_banners_provider.dart';

import '../../../shared/widgets/widgets.dart';

class BannersStoreScreen extends ConsumerWidget {
  final String storeId;
  final String country;

  const BannersStoreScreen({
    super.key,
    required this.storeId,
    required this.country,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final bannersState = ref.watch(bannersStoreProvider((country, int.parse(storeId))));

    return AppLayout(
      scaffoldKey: scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: bannersState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : bannersState.banners.isEmpty
                ? const Center(
                    child: Text(
                      'No hay banners registrados',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.separated(
                    itemCount: bannersState.banners.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final banner = bannersState.banners[index];
                      final isActive = banner.estado == '1';

                      return Card(
                        elevation: 3,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Imagen
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  banner.archivoImagen,
                                  width: 100,
                                  height: 70,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      Container(
                                        width: 100,
                                        height: 70,
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey,
                                        ),
                                      ),
                                ),
                              ),
                              const SizedBox(width: 16),

                              // Información
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      banner.texto,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Duración: ${banner.duracion} seg',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      'Orden: ${banner.orden}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),

                              // Estado y acciones
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? Colors.green[100]
                                          : Colors.red[100],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      isActive ? 'Activo' : 'Inactivo',
                                      style: TextStyle(
                                        color: isActive
                                            ? Colors.green[800]
                                            : Colors.red[800],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.blue),
                                        tooltip: 'Editar',
                                        onPressed: () {
                                          // TODO: implementar editar
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        tooltip: 'Eliminar',
                                        onPressed: () {
                                          // TODO: implementar eliminar
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: [
         CustomFloatingButton(
            heroTag: 'add',
            iconData: Icons.add,
            color: AppColors.primary,
            onPressed: () {
              
            },
          ),
      ],
    );
  }
}
