import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:klanetmarketers/features/auth/presentation/providers/auth_provider.dart';
import '../../../../config/utils/app_colors.dart';
import '../../../shared/widgets/widgets.dart';
// import '../providers/providers.dart';

class LoginScreen extends StatelessWidget {
  static const name = 'login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ContainerBackground(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                SvgPicture.asset(
                  'assets/images/logo_klanet_d.svg',
                  height: 70,
                  color: AppColors.secondary,
                ),
                const SizedBox(height: 80),
                Container(
                  height: size.height - 260,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                    ),
                  ),
                  child: const _LoginForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        showSnackbar(context, next.errorMessage);
      }
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            'Bienvenido a Klanet',
            style: textStyle.titleMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 70),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Iniciar sesión',
              // buttonColor: AppColors.primary,
              onPressed: () {
                ref.read(authProvider.notifier).authZitadel();
              },
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Registrarse',
              // buttonColor: AppColors.primary,
              // onPressed: () => ref.read(authProvider.notifier).getAuthZitadel(),
              onPressed: () => context.push('/register'),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '¿Olvidaste tu contraseña?',
                style: textStyle.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              TextButton(
                onPressed: () => context.push('/register'),
                child: Text(
                  'Recuperar',
                  style: textStyle.titleSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
