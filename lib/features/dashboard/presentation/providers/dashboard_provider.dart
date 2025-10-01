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
    getTimeZones();
  }

  Future<void> getTimeZones() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);
    final timeZones = await dashboardRepository.getTimeZones();
    state = state.copyWith(balance: timeZones, isLoading: false);
  }
}

class DashboardState {
  final Balance balance;
  final bool isLoading;

  DashboardState({Balance? balance, this.isLoading = false})
    : balance =
          balance ??
          Balance(
            balance: 0,
            timeZone: TimeZoneServer(time: '', tzServer: ''),
          );

  DashboardState copyWith({Balance? balance, bool? isLoading}) =>
      DashboardState(
        balance: balance ?? this.balance,
        isLoading: isLoading ?? this.isLoading,
      );
}
