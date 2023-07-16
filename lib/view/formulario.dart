import "package:flutter/material.dart";
import "package:lembretes_app/view/calendario.dart";

class FormularioDialog extends StatefulWidget {
  const FormularioDialog({super.key});

  @override
  State<FormularioDialog> createState() => _FormularioDialogState();
}

class _FormularioDialogState extends State<FormularioDialog> {
  bool paginaDois = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: !paginaDois
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            const Text("Novo Lembrete",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 24),
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Título do Lembrete",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                            const SizedBox(height: 8),
                            TextFormField(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    hintText: "Digite o título do lembrete...",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ))),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  paginaDois = true;
                                });
                              },
                              child: const Text("Próximo"),
                            ),
                          ])
                    : const Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            CalendarioDialog(),
                            SizedBox(height: 40),
                          ]))));
  }
}
