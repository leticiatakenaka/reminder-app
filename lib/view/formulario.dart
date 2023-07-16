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

  final diaPosterior = DateTime.now().add(const Duration(days: 1));
  late DateTime data = diaPosterior;

  late String titulo = "";

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> dadosFirebase = {};

    try {
      dadosFirebase = widget.documentSnapshot?.data() as Map<String, dynamic>;
    } catch (e) {
      print("Error: $e");
    }

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
                                    fontSize: 20,
                                    color: Color(0xFFAD1457),
                                  )),
                              const SizedBox(height: 24),
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Título do Lembrete",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
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
                                  initialValue: widget.atualizar
                                      ? titulo = dadosFirebase["lembrete"]
                                      : "",
                                  decoration: InputDecoration(
                                      filled: true,
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
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: const Color(0xFFAD1457),
                                ),
                                child: const Text(
                                  "Selecionar Data",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ]),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            const Text("Selecione a data",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFAD1457),
                                )),
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
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: const Color(0xFFAD1457),
                                ),
                                child: Text(
                                  widget.atualizar
                                      ? "Atualizar Lembrete"
                                      : "Adicionar Lembrete",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ))
                          ]))));
  }
}
