import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/packages/domain/domain.dart';
import 'package:klanetmarketers/features/packages/presentation/providers/package_repository_provider.dart';

final packageProvider = StateNotifierProvider.autoDispose<PackageNotifier, PackageState>((ref) {
      final packageRepository = ref.watch(packageRepositoryProvider);
      return PackageNotifier(packageRepository: packageRepository);
    });

class PackageNotifier extends StateNotifier<PackageState> {
  final PackagesRepository packageRepository;
  PackageNotifier({required this.packageRepository}) : super(PackageState());

  Future<void> getPackages(String country) async {
    state = state.copyWith(isLoading: true);
    try {
      final packages = await packageRepository.getPackages(country);
      if (!mounted) return;
      state = state.copyWith(isLoading: false,hasSearched: true,  packages: packages);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}

class PackageState {
  final bool isLoading;
  final bool hasSearched;
  final List<Package> packages;

  PackageState({this.isLoading = false, this.packages = const [], this.hasSearched = false});

  PackageState copyWith({
    bool? isLoading,
    bool? hasSearched,
    List<Package>? packages,
    List<Package>? digitalPackages,
    List<Package>? physicalPackages,
  }) {
    return PackageState(
      isLoading: isLoading ?? this.isLoading,
      hasSearched: hasSearched ?? this.hasSearched,
      packages: packages ?? this.packages,
    );
  }
}
