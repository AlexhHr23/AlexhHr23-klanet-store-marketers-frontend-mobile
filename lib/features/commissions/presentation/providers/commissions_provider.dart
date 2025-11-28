import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/commissions/domain/domain.dart';
import 'package:klanetmarketers/features/commissions/presentation/providers/commission_repository_provider.dart';

final commissionProvider =
    StateNotifierProvider.autoDispose<CommissionNotifier, CommmissionsState>((
      ref,
    ) {
      final commissionRepository = ref.watch(commissionRepositoryProvider);
      return CommissionNotifier(commissionRepository: commissionRepository);
    });

class CommissionNotifier extends StateNotifier<CommmissionsState> {
  final CommissionRepository commissionRepository;
  CommissionNotifier({required this.commissionRepository})
    : super(CommmissionsState()) {
    getNeworkCommissions('2025-10-28');
    // loadMockData();
  }

  Future<void> getNeworkCommissions(String date) async {
    try {
      state = state.copyWith(isLoading: true);

      final commissions = await commissionRepository.getNetworkCommissions(
        date,
      );

      final Map<String, List<NetworkCommission>> grouped = {};
      for (var commission in commissions) {
        final level = commission.nivel;
        if (!grouped.containsKey(level)) {
          grouped[level] = [];
        }
        grouped[level]!.add(commission);
      }

      state = state.copyWith(
        isLoading: false,
        commissions: commissions,
        groupedByLevel: grouped,
        hasSearched: true,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}

class CommmissionsState {
  final bool isLoading;
  final bool hasSearched;
  final List<NetworkCommission> commissions;
  final Map<String, List<NetworkCommission>> groupedByLevel;

  CommmissionsState({
    this.isLoading = false,
    this.hasSearched = false,
    this.commissions = const [],
    this.groupedByLevel = const {},
  });

  CommmissionsState copyWith({
    bool? isLoading,
    bool? hasSearched,
    List<NetworkCommission>? commissions,
    Map<String, List<NetworkCommission>>? groupedByLevel,
  }) => CommmissionsState(
    isLoading: isLoading ?? this.isLoading,
    hasSearched: hasSearched ?? this.hasSearched,
    commissions: commissions ?? this.commissions,
    groupedByLevel: groupedByLevel ?? this.groupedByLevel,
  );
}
