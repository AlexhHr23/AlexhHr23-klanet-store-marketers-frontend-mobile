import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/packages/domain/domain.dart';
import 'package:klanetmarketers/features/packages/presentation/providers/package_repository_provider.dart';

final getPackagesProvider = StateNotifierProvider.autoDispose
    .family<PackagesNotifier, PackagesState, String>((ref, country) {
      final packageRepository = ref.watch(packageRepositoryProvider);
      return PackagesNotifier(
        packageRepository: packageRepository,
        country: country,
      );
    });

class PackagesNotifier extends StateNotifier<PackagesState> {
  final PackagesRepository packageRepository;
  final String country;
  PackagesNotifier({required this.packageRepository, required this.country})
    : super(PackagesState()) {
    getPackages();
  }

  Future<void> getPackages() async {
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
}

class PackagesState {
  final bool isLoading;
  final List<Package> packages;
  final List<Package> digitalPackages;
  final List<Package> physicalPackages;
  PackagesState({
    this.isLoading = false,
    this.packages = const [],
    this.digitalPackages = const [],
    this.physicalPackages = const [],
  });

  PackagesState copyWith({
    bool? isLoading,
    bool? hasSearched,
    String? selectedCountry,
    List<Package>? packages,
    List<Package>? digitalPackages,
    List<Package>? physicalPackages,
  }) {
    return PackagesState(
      isLoading: isLoading ?? this.isLoading,
      packages: packages ?? this.packages,
      digitalPackages: digitalPackages ?? this.digitalPackages,
      physicalPackages: physicalPackages ?? this.physicalPackages,
    );
  }
}
