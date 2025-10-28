import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/shared/infrastructure/repositories/currency_repository_impl.dart';
import 'package:klanetmarketers/features/shared/providers/currency_repository_providerr.dart';
import '../domain/entities/entities.dart';

final currencyProvider = StateNotifierProvider<CurrencyNotifier, CurrencyState>(
  (ref) {
    final currencyRepository = ref.watch(currencyRepositoryProvider);
    return CurrencyNotifier(currencyRepository: currencyRepository);
  },
);

class CurrencyNotifier extends StateNotifier<CurrencyState> {
  final CurrencyRepositoryImpl currencyRepository;
  CurrencyNotifier({required this.currencyRepository})
    : super(CurrencyState()) {
    getCurrencies();
  }

  Future<void> getCurrencies() async {
    try {
      state = state.copyWith(isLoading: true);
      final currencies = await currencyRepository.getCurrencies();
      state = state.copyWith(currencies: currencies, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}

class CurrencyState {
  final bool isLoading;
  final List<Currency> currencies;

  CurrencyState({this.isLoading = false, this.currencies = const []});

  CurrencyState copyWith({bool? isLoading, List<Currency>? currencies}) =>
      CurrencyState(
        isLoading: isLoading ?? this.isLoading,
        currencies: currencies ?? this.currencies,
      );
}
