import 'package:klanetmarketers/features/shared/infrastructure/inputs/inputs.dart';

class StoreFormState {
  final String? id;
  final TextInput name;
  final TextInput description;
  final FacebookPixel fbPixel;
  final GoogleAnalytics gAnalytics;
  final Clarity msClarity;
  final String country;
  final String currency;

  StoreFormState({
    this.id,
    this.name = const TextInput.pure(),
    this.description = const TextInput.pure(),
    this.fbPixel = const FacebookPixel.pure(),
    this.gAnalytics = const GoogleAnalytics.pure(),
    this.country = '',
    this.msClarity = const Clarity.pure(),
    this.currency = '',
  });
}
