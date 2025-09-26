import 'package:flutter/material.dart';

class AcceptTermsScreen extends StatefulWidget {
  const AcceptTermsScreen({super.key});

  @override
  State<AcceptTermsScreen> createState() => _AcceptTermsScreenState();
}

class _AcceptTermsScreenState extends State<AcceptTermsScreen> {
  bool term1 = false;
  bool term2 = false;
  bool term3 = false;

  @override
  Widget build(BuildContext context) {
    final allAccepted = term1 && term2 && term3;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Términos y condiciones'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  CheckboxListTile(
                    value: term1,
                    onChanged: (value) =>
                        setState(() => term1 = value ?? false),
                    title: const Text(
                      'Acepto los términos y condiciones generales',
                    ),
                  ),
                  CheckboxListTile(
                    value: term2,
                    onChanged: (value) =>
                        setState(() => term2 = value ?? false),
                    title: const Text('Acepto la política de privacidad'),
                  ),
                  CheckboxListTile(
                    value: term3,
                    onChanged: (value) =>
                        setState(() => term3 = value ?? false),
                    title: const Text(
                      'Acepto recibir notificaciones y promociones',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: allAccepted
                    ? () {
                        // Aquí ya puedes acceder al registerFormProvider
                        // y mandar los datos al endpoint
                        print(
                          "Todos los términos aceptados. Enviar datos al backend.",
                        );
                      }
                    : null,
                child: const Text('Continuar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
