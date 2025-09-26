import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/auth/presentation/providers/register_form_provider.dart';
import '../../../shared/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ContainerBackground(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                // Icon Banner
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (!context.canPop()) return;
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        size: 40,
                        color: AppColors.secondary,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/images/logo_klanet_d.svg',
                      height: 70,
                      color: AppColors.secondary,
                    ),
                    const Spacer(flex: 1),
                  ],
                ),

                // const SizedBox(height: ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: scaffoldBackgroundColor),
                  child: const _RegisterForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends ConsumerWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerFormProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          const SizedBox(height: 50),

          CustomTextFormField(
            label: 'Nombre',
            keyboardType: TextInputType.name,
            onChanged: ref.read(registerFormProvider.notifier).onNameChange,
            errorMessage: registerForm.isFormPosted
                ? registerForm.name.errorMessage
                : null,
          ),
          const SizedBox(height: 30),

          CustomTextFormField(
            label: 'Apellido',
            keyboardType: TextInputType.name,
            onChanged: ref.read(registerFormProvider.notifier).onLastNameChange,
            errorMessage: registerForm.isFormPosted
                ? registerForm.lastName.errorMessage
                : null,
          ),
          const SizedBox(height: 30),

          CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(registerFormProvider.notifier).onEmailChange,
            errorMessage: registerForm.isFormPosted
                ? registerForm.email.errorMessage
                : null,
          ),
          const SizedBox(height: 30),

          CustomPhoneFormField(
            initialCountry: 'MX',
            initialValue: registerForm.phoneNumber.value,
            onChanged: (phone, isoCode, countryCode) {
              ref
                  .read(registerFormProvider.notifier)
                  .onPhoneChange(phone, isoCode, countryCode ?? '');

              // print('Teléfono: $phone, ISO: $isoCode, Código del País: $countryCode');
            },
            errorMessage: registerForm.isFormPosted
                ? registerForm.phoneNumber.errorMessage
                : null,
          ),
          const SizedBox(height: 30),

          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: ref.read(registerFormProvider.notifier).onPasswordChange,
            errorMessage: registerForm.isFormPosted
                ? registerForm.password.errorMessage
                : null,
          ),

          const SizedBox(height: 30),

          CustomTextFormField(
            label: 'Repetir contraseña',
            obscureText: true,
            onChanged: ref
                .read(registerFormProvider.notifier)
                .onRepeatPasswordChange,
            errorMessage: registerForm.isFormPosted
                ? registerForm.repeatPassword.errorMessage
                : null,
          ),

          const SizedBox(height: 30),

          CustomTextFormField(
            label: 'Código de referido',
            keyboardType: TextInputType.name,
            onChanged: ref.read(registerFormProvider.notifier).onCodeChange,
            errorMessage: registerForm.isFormPosted
                ? registerForm.code?.errorMessage
                : null,
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Crear',
              onPressed: () {
                ref.read(registerFormProvider.notifier).onFormSubmit();
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿Ya tienes cuenta?'),
              TextButton(
                onPressed: () {
                  if (context.canPop()) {
                    return context.pop();
                  }
                  context.go('/login');
                },
                child: const Text('Ingresa aquí'),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
