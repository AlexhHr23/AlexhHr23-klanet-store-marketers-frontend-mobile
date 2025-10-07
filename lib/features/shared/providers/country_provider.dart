import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/shared/infrastructure/repositories/country_repository_impl.dart';
import 'package:klanetmarketers/features/shared/providers/country_repository_provider.dart';
import '../domain/entities/entities.dart';

final countryProvider = StateNotifierProvider<CountryNotifier, CountryState>((
  ref,
) {
  final countryRepository = ref.watch(countryRepositoryProvider);
  return CountryNotifier(countryRepository: countryRepository);
});

class CountryNotifier extends StateNotifier<CountryState> {
  final CountryRepositoryImpl countryRepository;
  CountryNotifier({required this.countryRepository}) : super(CountryState()) {
    getCountries();
  }

  Future<void> getCountries() async {
    try {
      state = state.copyWith(isLoading: true);
      final countries = await countryRepository.getCountries();
      state = state.copyWith(countries: countries, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}

class CountryState {
  final bool isLoading;
  final List<Country> countries;

  CountryState({this.isLoading = false, this.countries = const []});

  CountryState copyWith({bool? isLoading, List<Country>? countries}) =>
      CountryState(
        isLoading: isLoading ?? this.isLoading,
        countries: countries ?? this.countries,
      );
}
