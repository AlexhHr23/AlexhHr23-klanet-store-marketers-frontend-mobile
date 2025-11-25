import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:klanetmarketers/config/router/app_router_notifier.dart';
import 'package:klanetmarketers/features/packages/presentation/screens/screens.dart';
import '../../features/auth/presentation/presentation.dart';
import '../../features/dashboard/presentation/presentation.dart';
import '../../features/stores/presentation/presentation.dart';
import '../../features/products/presentation/presentation.dart';

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
      GoRoute(path: '/', builder: (context, state) => HomeScreen()),

      //* Store Routes
      GoRoute(path: '/stores', builder: (context, state) => StoresScreen()),
      GoRoute(
        path: '/stores/banners/:storeId',
        builder: (context, state) => BannersStoreScreen(
          storeId: state.pathParameters['storeId'] ?? 'no-id',
          country: state.uri.queryParameters['country'] ?? 'no-country',
        ),
      ),
      GoRoute(
        path: '/stores/products/:storeId',
        builder: (context, state) => ProductsStoreScreen(
          storeId: state.pathParameters['storeId'] ?? 'no-id',
          country: state.uri.queryParameters['country'] ?? 'no-country',
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
          country: state.uri.queryParameters['country'] ?? 'no-country',
        ),
      ),

      //* Catalog Routes
      GoRoute(
        path: '/dashboard-job',
        builder: (context, state) => CountriesScreen(),
        routes: [
          GoRoute(
            path: '/:country',
            builder: (context, state) => CategoriesCountryScreen(
              country: state.pathParameters['country'] ?? 'no-country',
            ),
            routes: [
              GoRoute(
                path: '/:categoryId',
                builder: (context, state) => ProductsCategoryScreen(
                  country: state.pathParameters['country'] ?? 'no-country',
                  categoryId: (state.pathParameters['categoryId'] ?? 'no-id'),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(path: '/packages', builder: (context, state) => PackagesScreen()),
      GoRoute(
        path: '/form-packages',
        builder: (context, state) => const CreatePackageScreen(),
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
