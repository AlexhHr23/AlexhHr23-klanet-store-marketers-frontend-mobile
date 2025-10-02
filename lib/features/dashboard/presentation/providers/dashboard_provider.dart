import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/dashboard/domain/entities/entities.dart';
import 'package:klanetmarketers/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:klanetmarketers/features/dashboard/presentation/providers/order_repository_provider.dart';

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
      final dashboardRepository = ref.watch(dashboardRepositoryProvider);
      return DashboardNotifier(dashboardRepository: dashboardRepository);
    });

class DashboardNotifier extends StateNotifier<DashboardState> {
  final DashboardRepository dashboardRepository;

  DashboardNotifier({required this.dashboardRepository})
    : super(DashboardState()) {
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    state = state.copyWith(isLoading: true);

    try {
      final balance = await dashboardRepository.getTimeZones();
      state = state.copyWith(balance: balance);

      final marketerProfile = await dashboardRepository.getMarketerProfile();
      state = state.copyWith(
        marketerProfile: marketerProfile,
        isLoading: false,
      );

      final banners = await dashboardRepository.getBanners();
      state = state.copyWith(banners: banners, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> getBalance() async {
    state = state.copyWith(isLoading: true);
    final timeZones = await dashboardRepository.getTimeZones();
    state = state.copyWith(balance: timeZones, isLoading: false);
  }

  Future<void> getMarketerProfile() async {
    state = state.copyWith(isLoading: true);
    final marketerProfile = await dashboardRepository.getMarketerProfile();
    state = state.copyWith(marketerProfile: marketerProfile, isLoading: false);
  }

  Future<void> getBanners() async {
    state = state.copyWith(isLoading: true);
    final banners = await dashboardRepository.getBanners();
    state = state.copyWith(banners: banners, isLoading: false);
  }
}

class DashboardState {
  final bool isLoading;
  final Balance balance;
  final List<String> banners;
  final MarketerProfile marketerProfile;

  DashboardState({
    this.isLoading = false,
    this.banners = const [],
    Balance? balance,
    MarketerProfile? marketerProfile,
  }) : balance = balance ?? Balance.empty(),
       marketerProfile = marketerProfile ?? MarketerProfile.empty();

  DashboardState copyWith({
    bool? isLoading,
    Balance? balance,
    MarketerProfile? marketerProfile,
    List<String>? banners,
  }) => DashboardState(
    balance: balance ?? this.balance,
    marketerProfile: marketerProfile ?? this.marketerProfile,
    banners: banners ?? this.banners,
    isLoading: isLoading ?? this.isLoading,
  );
}
