import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class FormularioDialog extends StatefulWidget {
  final FirebaseFirestore db;
  final bool atualizar;
  final DocumentSnapshot? documentSnapshot;

  const FormularioDialog(
      {required this.db,
      required this.atualizar,
      required this.documentSnapshot,
      Key? key})
      : super(key: key);

  @override
  State<FormularioDialog> createState() => _FormularioDialogState();
}

class _FormularioDialogState extends State<FormularioDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool paginaDois = false;

  String? titulo;

  final diaPosterior = DateTime.now().add(const Duration(days: 1));
  late DateTime data = diaPosterior;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> dadosFirebase =
        widget.documentSnapshot?.data() as Map<String, dynamic>;
    titulo = dadosFirebase["lembrete"] ?? "";

    return Dialog(
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: !paginaDois
                    ? Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  widget.atualizar
                                      ? "Atualizar Lembrete"
                                      : "Novo Lembrete",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Informe o título";
                                    }
                                    return null;
                                  },
                                  initialValue: titulo,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      hintText:
                                          "Digite o título do lembrete...",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ))),
                              const SizedBox(height: 40),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      paginaDois = true;
                                    });
                                  }
                                },
                                child: const Text("SELECIONAR DATA"),
                              ),
                            ]),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            CalendarDatePicker(
                                firstDate: diaPosterior,
                                initialDate: widget.atualizar
                                    ? (dadosFirebase["data"] as Timestamp)
                                        .toDate()
                                    : diaPosterior,
                                lastDate: DateTime(2025),
                                onDateChanged: (DateTime value) {
                                  data = value;
                                }),
                            const SizedBox(height: 40),
                            ElevatedButton(
                                onPressed: () {
                                  if (widget.atualizar) {
                                    widget.db
                                        .collection("lembretes")
                                        .doc(widget.documentSnapshot?.id)
                                        .update(
                                            {"lembrete": titulo, "data": data});
                                  } else {
                                    widget.db.collection("lembretes").add(
                                        {"lembrete": titulo, "data": data});
                                  }
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  widget.atualizar
                                      ? "ATUALIZAR LEMBRETE"
                                      : "ADICIONAR LEMBRETE",
                                ))
                          ]))));
  }
}
