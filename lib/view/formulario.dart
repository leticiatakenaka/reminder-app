import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class FormularioDialog extends StatefulWidget {
  final FirebaseFirestore db;

  const FormularioDialog({required this.db, Key? key}) : super(key: key);

  @override
  State<FormularioDialog> createState() => _FormularioDialogState();
}

class _FormularioDialogState extends State<FormularioDialog> {
  bool paginaDois = false;

  String? titulo;

  final diaPosterior = DateTime.now().add(const Duration(days: 1));
  late DateTime data;

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
                                onChanged: (String val) {
                                  titulo = val;
                                },
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
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            CalendarDatePicker(
                                firstDate: diaPosterior,
                                initialDate: diaPosterior,
                                lastDate: DateTime(2025),
                                onDateChanged: (DateTime value) {
                                  data = value;
                                }),
                            const SizedBox(height: 40),
                            ElevatedButton(
                                onPressed: () {
                                  widget.db
                                      .collection("lembretes")
                                      .add({"lembrete": titulo, "data": data});
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "ADICIONAR LEMBRETE",
                                ))
                          ]))));
  }
}
