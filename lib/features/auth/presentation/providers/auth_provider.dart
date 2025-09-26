import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/auth/domain/repositories/auth_repository.dart';
import 'package:klanetmarketers/features/auth/infrastructure/errors/auth_errors.dart';
import 'package:klanetmarketers/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:klanetmarketers/features/shared/infrastructure/services/key_value_storage_impl.dart';

import '../../domain/entities/entities.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();
  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageServiceImpl keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }) : super(AuthState()) {
    getUser();
  }

  Future<void> authZitadel() async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      final auth = await authRepository.zitadelAuth();

      final acessToken = auth.tokenId;

      await keyValueStorageService.setKeyValue('acessToken', acessToken);

      print('acessToken: $acessToken');
    } catch (e) {
      state = state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> getUser() async {
    final accessToken = await keyValueStorageService.getValue<String>(
      'acessToken',
    );

    if (accessToken == null) {
      await logout('', 'No hay token guardado');
      return;
    }

    try {
      final user = await authRepository.getUser(accessToken);
      _setLoggedUser(user, accessToken);
    } on CustomError catch (e) {
      await logout(accessToken, e.message);
    } catch (e) {
      await logout(accessToken, 'Error no controlado');
    }
  }

  void _setLoggedUser(User user, String accessToken) {
    state = state.copyWith(
      authStatus: AuthStatus.authenticated,
      user: user.copyWith(
        jwt: accessToken,
        marketer: user.marketer,
        roles: user.roles,
        preferences: user.preferences,
        profile: user.profile,
        uid: user.uid,
        zid: user.zid,
      ),
    );
  }

  Future<void> logout(String accessToken, String? errorMessage) async {
    print('Ejecutando logout');
    // await authRepository.logout(accessToken);
    state = state.copyWith(
      authStatus: AuthStatus.unauthenticated,
      user: null,
      errorMessage: errorMessage,
    );
    await keyValueStorageService.removeKey('acessToken');
  }
}

enum AuthStatus { checking, authenticated, unauthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
