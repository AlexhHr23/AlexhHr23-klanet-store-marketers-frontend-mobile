import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/packages/domain/domain.dart';
import 'package:klanetmarketers/features/packages/presentation/providers/package_repository_provider.dart';

final packageProvider =
    StateNotifierProvider.autoDispose<PackageNotifier, PackageState>((ref) {
      final packageRepository = ref.watch(packageRepositoryProvider);
      return PackageNotifier(packageRepository: packageRepository);
    });

class PackageNotifier extends StateNotifier<PackageState> {
  final PackagesRepository packageRepository;
  PackageNotifier({required this.packageRepository}) : super(PackageState());

  Future<void> selectCountry(String country) async {
    state = state.copyWith(selectedCountry: country);
  }

  Future<bool> createPackage(
    String country,
    Map<String, dynamic> packageLike,
  ) async {
    try {
      final package = await packageRepository.createPackage(
        country,
        packageLike,
      );
      final updatedList = [...state.packages, package];
      state = state.copyWith(isLoading: false, packages: updatedList);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> getPackages(String country) async {
    state = state.copyWith(isLoading: true);
    try {
      final packages = await packageRepository.getPackages(country);
      if (!mounted) return;
      state = state.copyWith(
        isLoading: false,
        hasSearched: true,
        packages: packages,
        digitalPackages: packages.where((p) => p.tipo == '0').toList(),
        physicalPackages: packages.where((p) => p.tipo == '1').toList(),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<bool> deletePackage(String country, int productId) async {
    try {
      final status = await packageRepository.deletePackage(country, productId);
      if (!mounted) return false;

      if (status == 'success') {
        final updatedList = state.packages
            .where((p) => p.id != productId)
            .toList();
        state = state.copyWith(isLoading: false, packages: updatedList);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

class PackageState {
  final bool isLoading;
  final bool hasSearched;
  final String selectedCountry;
  final List<Package> packages;

  PackageState({
    this.isLoading = false,
    this.packages = const [],
    this.hasSearched = false,
    this.selectedCountry = '',
  });

  PackageState copyWith({
    bool? isLoading,
    bool? hasSearched,
    String? selectedCountry,
    List<Package>? packages,
    List<Package>? digitalPackages,
    List<Package>? physicalPackages,
  }) {
    return PackageState(
      isLoading: isLoading ?? this.isLoading,
      hasSearched: hasSearched ?? this.hasSearched,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      packages: packages ?? this.packages,
    );
  }
}
