import "package:flutter/material.dart";
import "formulario.dart";

class Home extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Home({super.key});

  void _mostrarFormulario(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const FormularioDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: ElevatedButton(
                      onPressed: () => _mostrarFormulario(context),
                      child: const Text("Criar Lembrete")))
            ]));
  }
}
