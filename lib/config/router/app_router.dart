import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:klanetmarketers/config/router/app_router_notifier.dart';
import '../../features/auth/presentation/presentation.dart';
import '../../features/dashboard/presentation/presentation.dart';
import '../../features/stores/presentation/presentation.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/callback',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/callback',
        builder: (context, state) => const CallbackScreen(),
      ),

      //* Auth Routes
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      //Private routes
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),

      GoRoute(
        path: '/stores',
        builder: (context, state) => const StoresScreen(),
      ),
      GoRoute(
        path: '/stores/banners/:storeId',
        builder: (context, state) => BannersStoreScreen(
          storeId: state.pathParameters['storeId'] ?? 'no-id',
          country: state.uri.queryParameters['country'] ?? 'no-country'
        ),
      ),
      GoRoute(
        path: '/form-stores',
        builder: (context, state) => const CreateEditAddresScreen(),
      ),
       GoRoute(
        path: '/form-banners/:storeId',
        builder: (context, state) => CreateEditBanner(
          storeId: state.pathParameters['storeId'] ?? 'no-id',
          country: state.uri.queryParameters['country'] ?? 'no-country'
        ),
      ),
    ],
    redirect: (context, state) {
      final authStatus = goRouterNotifier.authStatus;
      final isGoingTo = state.matchedLocation;

      if (isGoingTo == '/callback' && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.unauthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') {
          return null;
        }

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/callback') {
          return '/';
        }
      }

      return null;
    },
  );
});
