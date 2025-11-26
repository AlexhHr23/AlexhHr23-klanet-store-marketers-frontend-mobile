import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/packages/domain/domain.dart';
import 'package:klanetmarketers/features/packages/presentation/providers/package_repository_provider.dart';

final getPackageProvider = StateNotifierProvider.autoDispose
    .family<
      PackageByIdNotifier,
      PackageByIdState,
      (String country, int packageId)
    >((ref, params) {
      final packageRepository = ref.watch(packageRepositoryProvider);
      final (country, packageId) = params;
      return PackageByIdNotifier(
        packageRepository: packageRepository,
        country: country,
        packageId: packageId,
      );
    });

class PackageByIdNotifier extends StateNotifier<PackageByIdState> {
  final PackagesRepository packageRepository;
  final String country;
  final int packageId;
  PackageByIdNotifier({
    required this.packageRepository,
    required this.country,
    required this.packageId,
  }) : super(PackageByIdState()) {
    getPackageById();
  }

  Future<void> getPackageById() async {
    state = state.copyWith(isLoading: true);
    try {
      final package = await packageRepository.getPackageById(
        country,
        packageId,
      );
      if (!mounted) return;
      state = state.copyWith(
        isLoading: false,
        package: package,
        products: package.productos,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<bool> deleteProductByPackage(int productId) async {
    try {
      final status = await packageRepository.deleteProductFromPackage(
        country,
        packageId,
        productId,
      );
      if (!mounted) return false;

      if (status == 'success') {
        final updatedList = state.products
            .where((p) => p.idProducto != productId)
            .toList();
        state = state.copyWith(isLoading: false, products: updatedList);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

class PackageByIdState {
  final bool isLoading;
  final Package? package;
  final List<ProductPackage> products;
  PackageByIdState({
    this.isLoading = false,
    this.package,
    this.products = const [],
  });

  PackageByIdState copyWith({
    bool? isLoading,
    Package? package,
    List<ProductPackage>? products,
  }) {
    return PackageByIdState(
      isLoading: isLoading ?? this.isLoading,
      package: package ?? this.package,
      products: products ?? this.products,
    );
  }
}
