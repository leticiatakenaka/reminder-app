import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:intl/intl.dart";

import "formulario.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Home());
}

final db = FirebaseFirestore.instance;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFAD1457),
          title: const Text("Lista de Lembretes",
              style: TextStyle(fontSize: 24, color: Colors.white)),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _mostrarFormulario(context, false, null);
            },
            backgroundColor: const Color(0xFFAD1457),
            foregroundColor: const Color(0xFFE1BEE7),
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                ])),
        body: StreamBuilder(
            stream: db.collection("lembretes").snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
              docs.sort((a, b) {
                int aSeconds = a["data"].seconds;
                int bSeconds = b["data"].seconds;
                return aSeconds.compareTo(bSeconds);
              });

              Map<String, List<DocumentSnapshot>> lembretesAgrupados = {};

              for (var doc in docs) {
                int seconds = doc["data"].seconds;
                DateTime data =
                    DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
                String dataFormatada =
                    DateFormat("EEE, dd/MM/yyyy", "pt_BR").format(data);

                if (lembretesAgrupados.containsKey(dataFormatada)) {
                  lembretesAgrupados[dataFormatada]!.add(doc);
                } else {
                  lembretesAgrupados[dataFormatada] = [doc];
                }
              }

              return ListView.builder(
                  itemCount: lembretesAgrupados.length,
                  itemBuilder: (context, int index) {
                    String dataFormatada =
                        lembretesAgrupados.keys.elementAt(index);
                    List<DocumentSnapshot> lembretesParaData =
                        lembretesAgrupados[dataFormatada]!;

                    return Column(children: [
                      ListTile(
                        title: Text(dataFormatada),
                        titleTextStyle: const TextStyle(
                            color: Color(0xFFAD1457), fontSize: 18),
                      ),
                      ...lembretesParaData.map((documentSnapshot) {
                        return ListTile(
                            title:
                                Text("       ${documentSnapshot["lembrete"]}"),
                            onTap: () {
                              _mostrarFormulario(
                                  context, true, documentSnapshot);
                            },
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline),
                              color: const Color(0xFFAD1457),
                              onPressed: () {
                                db
                                    .collection("lembretes")
                                    .doc(documentSnapshot.id)
                                    .delete();
                              },
                            ));
                      }).toList(),
                    ]);
                  });
            }));
  }
}

void _mostrarFormulario(
    BuildContext context, bool atualizar, DocumentSnapshot? documentSnapshot) {
  showDialog(
      context: context,
      builder: (BuildContext context) => FormularioDialog(
          db: FirebaseFirestore.instance,
          atualizar: atualizar,
          documentSnapshot: documentSnapshot));
}
